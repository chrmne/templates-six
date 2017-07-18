{include file="$template/includes/tablelist.tpl" tableName="SslList" startOrderCol="3" filterColumn="0" noSortColumns="4"}

<div class="table-container clearfix">
    <table id="tableSslList" class="table table-list">
        <thead>
            <tr>
                <th>Domain</th>
                <th>SSL Product</th>
                <th>Order Date</th>
                <th>Renewal Date</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            {foreach $sslProducts as $sslProduct}
                <tr>
                    {if $sslProduct->addonId && $sslProduct->addonId > 0}
                        <td>
                            {if $sslProduct->status == 'Awaiting Configuration'}
                                <label class="label label-info">Awaiting Configuration</label>
                            {else}
                                {if $sslProduct->addon->service->domain}{$sslProduct->addon->service->domain}{else}-{/if}
                                {if $sslProduct->addon->nextDueDate->isPast()}
                                    <label class="label label-default">Expired</label>
                                {elseif $sslProduct->addon->nextDueDate->diffInDays() < 60}
                                    <label class="label label-danger">Expiring Soon!</label>
                                {/if}
                            {/if}
                        </td>
                        <td>
                            {$sslProduct->addon->productAddon->name}
                            <label class="label label-{if $sslProduct->validationType == 'DV'}default{elseif $sslProduct->validationType == 'OV'}warning{elseif $sslProduct->validationType == 'EV'}success{/if}">
                                {$sslProduct->validationType}
                            </label>
                        </td>
                        <td><span class="hidden">{$sslProduct->addon->registrationDate->toDateString()}</span>{$sslProduct->addon->registrationDate->format({$smarty.const.CLIENT_DATE_FORMAT})}</td>
                        <td><span class="hidden">{$sslProduct->addon->nextDueDate->toDateString()}</span>{$sslProduct->addon->nextDueDate->format({$smarty.const.CLIENT_DATE_FORMAT})}</td>
                        <td>
                            {if $sslProduct->status == 'Awaiting Configuration'}
                                <a href="{$sslProduct->getConfigurationUrl()}" class="btn btn-default btn-sm">Configure</a>
                            {/if}
                            {if !$sslProduct->addon->nextDueDate->isPast()}
                                <a href="#" class="btn btn-default btn-sm"{if $sslProduct->getCertificateType() == 'EV'} disabled="disabled"{/if}>Upgrade</a>
                            {/if}
                            <a href="#" class="btn btn-default btn-sm">Renew</a>
                        </td>
                    {else}
                        <td>
                            {if $sslProduct->status == 'Awaiting Configuration'}
                                <label class="label label-info">Awaiting Configuration</label>
                            {else}
                                {if $sslProduct->service->domain}{$sslProduct->service->domain}{else}-{/if}
                                {if $sslProduct->service->nextDueDate->isPast()}
                                    <label class="label label-default">Expired</label>
                                {elseif $sslProduct->service->nextDueDate->diffInDays() < 60}
                                    <label class="label label-danger">Expiring Soon!</label>
                                {/if}
                            {/if}
                        </td>
                        <td>
                            {$sslProduct->service->product->name}
                            <label class="label label-{if $sslProduct->getCertificateType() == 'DV'}default{elseif $sslProduct->getCertificateType() == 'OV'}warning{elseif $sslProduct->getCertificateType() == 'EV'}success{/if}">
                                {$sslProduct->getCertificateType()}
                            </label>
                        </td>
                        <td><span class="hidden">{$sslProduct->service->registrationDate->toDateString()}</span>{$sslProduct->service->registrationDate->format({$smarty.const.CLIENT_DATE_FORMAT})}</td>
                        <td><span class="hidden">{$sslProduct->service->nextDueDate->toDateString()}</span>{$sslProduct->service->nextDueDate->format({$smarty.const.CLIENT_DATE_FORMAT})}</td>
                        <td>
                            {if $sslProduct->status == 'Awaiting Configuration'}
                                <a href="{$sslProduct->getConfigurationUrl()}" class="btn btn-default btn-sm">Configure</a>
                            {/if}
                            {if !$sslProduct->service->nextDueDate->isPast()}
                                <a href="#" class="btn btn-default btn-sm"{if $sslProduct->getCertificateType() == 'EV'} disabled="disabled"{/if}>Upgrade</a>
                            {/if}
                            <a href="#" class="btn btn-default btn-sm">Renew</a>
                        </td>
                    {/if}

                </tr>
            {/foreach}
        </tbody>
    </table>
</div>


<div class="row">
    <div class="col-md-6">
        <div class="alert alert-warning">
            <div class="clearfix">
                <i class="fa fa-server fa-4x pull-right"></i>
                <h3>Upgrade to Wildcard</h3>
                <p class="font-bold text-warning">Some text goes here...</p>
            </div>

            <p>A wildcard SSL certificate allows you to use SSL on an unlimited number of subdomains.</p>

            <a href="cart.php" class="btn btn-warning">
                Explore OV SSL Options
            </a>
        </div>
    </div>
    <div class="col-md-6">
        <div class="alert alert-success">
            <div class="clearfix">
                <i class="fa fa-globe fa-4x pull-right"></i>
                <h3>Upgrade to EV</h3>
                <p class="font-bold text-success">Some text goes here...</p>
            </div>

            <p>EV SSL Certificates give you the green browser address bar and display your company name alongside your domain.</p>

            <a href="cart.php" class="btn btn-success">
                Explore EV SSL Options
            </a>
        </div>
    </div>
</div>
