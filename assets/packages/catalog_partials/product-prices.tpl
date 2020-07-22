{**
 * 2007-2017 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/osl-3.0.php
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to http://www.prestashop.com for more information.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2017 PrestaShop SA
 * @license   http://opensource.org/licenses/osl-3.0.php Open Software License (OSL 3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}
  {* For Packages - By Alekuoshu *}
<div class="product-prices">
    {if $product.show_price}
        {block name='product_price'}
            <div
              class="product-price h5 product-price-and-shipping mode-packages {if $product.has_discount}has-discount{/if}"
              itemprop="offers"
              itemscope
              itemtype="https://schema.org/Offer"
              data-price="{$product.price_amount}" data-sign="{$currency.sign}"
            >
                <link itemprop="availability" href="https://schema.org/InStock"/>
                <meta itemprop="priceCurrency" content="{$currency.iso_code}">
                <div class="current-price">
                    {if $product.has_discount}
                        <div class="current-price-discount">
                            <span class="product-discount">
                                {hook h='displayProductPriceBlock' product=$product type="old_price"}
                                <span class="regular-price">{$product.regular_price}</span>
                            </span>
                            {*
                            {if $product.discount_type === 'percentage'}
                                <span class="discount discount-percentage">{l s='Save %percentage%' d='Shop.Theme.Catalog' sprintf=['%percentage%' => $product.discount_percentage_absolute]}</span>
                            {else}
                                <span class="discount discount-amount">
                                    {l s='Save %amount%' d='Shop.Theme.Catalog' sprintf=['%amount%' => $product.discount_to_display]}
                                </span>
                            {/if}
                            *}
                            {if $product.discount_type === 'percentage'}
                                <span class="sale_product_percentage">{$product.discount_percentage} {l s='dscto' d='Shop.Theme.Catalog'}</span>
                            {/if}
                        </div>
                    {/if}
                    <div class="current-price-item">
                        {* <span itemprop="price" class="price" content="{$product.price_amount}">{$product.price}</span> *}
                        {if $currency.iso_code == 'COP'}
                            <span itemprop="price" class="price" content="{$product.price_amount}">{$currency.sign}{($product.price_amount|floatval*$product.minimal_quantity|intval)|number_format:0:',':'.'}</span>
                        {else}
                            <span itemprop="price" class="price" content="{$product.price_amount}">{$currency.sign}{($product.price_amount|floatval*$product.minimal_quantity|intval)|number_format:2:'.':','}</span>
                        {/if}
                        {if isset($envio_gratis) && $envio_gratis == 1}
                            <div class="text_envio_gratis">
                                <img src="{$urls.theme_assets}img/fast-delivery.svg">{l s='Envio Gratis' d='Shop.Theme.Catalog'}
                            </div>
                        {/if}
                    </div>
                </div>
                {block name='product_unit_price'}
                    {if $displayUnitPrice}
                        <p class="product-unit-price sub">{l s='(%unit_price%)' d='Shop.Theme.Catalog' sprintf=['%unit_price%' => $product.unit_price_full]}</p>
                    {/if}
                {/block}
            </div>
        {/block}
        {block name='product_without_taxes'}
            {if $priceDisplay == 2}
                <p class="product-without-taxes">{l s='%price% tax excl.' d='Shop.Theme.Catalog' sprintf=['%price%' => $product.price_tax_exc]}</p>
            {/if}
        {/block}
        {block name='product_pack_price'}
            {if $displayPackPrice}
                <p class="product-pack-price"><span>{l s='Instead of %price%' d='Shop.Theme.Catalog' sprintf=['%price%' => $noPackPrice]}</span></p>
            {/if}
        {/block}

        {block name='product_ecotax'}
            {if $product.ecotax.amount > 0}
                <p class="price-ecotax">{l s='Including %amount% for ecotax' d='Shop.Theme.Catalog' sprintf=['%amount%' => $product.ecotax.value]}
                    {if $product.has_discount}
                        {l s='(not impacted by the discount)' d='Shop.Theme.Catalog'}
                    {/if}
                </p>
            {/if}
        {/block}
    {/if}
    {*
    {if !$configuration.is_catalog}
        {block name='product_availability'}
            {if $product.show_availability && $product.availability_message}
                <div class="label-small">
                    <span class="control-label title_font">{l s="Availability"}:</span>
                    <div id="product-availability" class="type_{$product.availability}">
                        {$product.availability_message}
                    </div>
                </div>
            {/if}
        {/block}
    {/if}
    *}
    {*
    <div class="label-small">
        <span class="control-label title_font">{l s="Reference"}:</span>
        <div class="reference-detail">
            {$product.reference}
        </div>
    </div>
    *}
    {if $product.show_price}
        {hook h='displayProductPriceBlock' product=$product type="weight" hook_origin='product_sheet'}
        {*
        {if $configuration.display_taxes_label}
            <div class="label-small">
                <span class="control-label title_font">{l s="Tax shipping"}:</span>
                <div class="tax-shipping-delivery-label">
                    {$product.labels.tax_long}
                </div>
            </div>
        {/if}
        *}
        {hook h='displayProductPriceBlock' product=$product type="price"}
        {hook h='displayProductPriceBlock' product=$product type="after_price"}
    {/if}
</div>