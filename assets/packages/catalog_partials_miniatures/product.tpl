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
<div class="item col-xs-6 col-sm-6 col-md-4">
    <div class="item-inner hover_second_img">
        <div class="product-miniature js-product-miniature" data-id-product="{$product.id_product}" data-id-product-attribute="{$product.id_product_attribute}" itemscope itemtype="http://schema.org/Product">
            <div class="list-functional-buttons">
                {hook h='displayProductListFunctionalButtons' product=$product}
            </div>
            <div class="left-product" style="cursor: pointer;" onclick="window.location='{$product.url}';">
                <a href="{$product.url}" title="{$product.name}"
                  class="loading_element"
                  style="padding-bottom:{$style_padding}%"
                >
                    <img
                      class="img_element"
                      src = "{$product.cover.bySize.home_default.url}"
                      alt=""
                      width="{$width_product}"
                      height="{$height_product}"
                    >
                   {if isset($product.images[1])}
                       <span class="hover_image" style="background-image:url({$product.images[1].bySize.home_default.url})"></span>
                   {/if}
                </a>
                {if $product.main_variants}
                    <div class="pick-color">
                        {foreach from=$product.main_variants item=variant}
                            <a href="{$variant.url}"
                               class="{$variant.type}"
                               title="{$variant.name}"
                              {if $variant.html_color_code} style="background-color: {$variant.html_color_code}" {/if}
                              {if $variant.texture} style="background-image: url({$variant.texture})" {/if}>
                            </a>
                        {/foreach}
                    </div>
                {/if}
            </div>
            <div class="right-product">
                <div class="product-description" style="cursor: pointer;" onclick="window.location='{$product.url}';">
                    <div class="product_name" itemprop="name">
                        <a href="{$product.url}">{$product.name}</a>
                    </div>
                    {foreach $product.features as $feature}
                        {if $feature.name == 'Sabor' }
                            <span class="features" style="display: inline-block; width: 100%;">Sabor: {$feature.value|escape:'htmlall':'UTF-8'}</span>
                        {/if}
                    {/foreach}

                    {hook h='displayProductListReviews' product=$product}
                </div>
                {* {'Mode Package!'|@var_dump} *}
                <div class="content-action-product">
                    <form action="{$urls.pages.cart}" method="post">
                        {if $product.show_price}
                            <div class="product-price-and-shipping mode-packages" data-price="{$product.price_amount}" data-sign="{$currency.sign}">
                                {hook h='displayProductPriceBlock' product=$product type="before_price"}
                                {if $product.has_discount}
                                    {hook h='displayProductPriceBlock' product=$product type="old_price"}
                                    <span class="regular-price">{$product.regular_price}</span>
                                {/if}
                                {if isset($product.show_condition) && isset($product.condition.type) && $product.show_condition == 1}
                                    <span class="new_product"><span>{$product.condition.type}</span></span>
                                {/if}
                                {if $product.has_discount}
                                    {if $product.discount_type === 'percentage'}
                                        <span class="sale_product_percentage">{$product.discount_percentage}</span>
                                    {/if}
                                {/if}
                                {if $product.has_discount}
                                    <br />
                                {else}
                                    <span class="not_discount"></span>
                                {/if}
                                {* <span class="price">{$product.price}</span> *}
                                {if $currency.iso_code == 'COP'}
                                    <span class="price">{$currency.sign}{($product.price_amount|floatval*$product.minimal_quantity|intval)|number_format:0:',':'.'}</span>
                                {else}
                                    <span class="price">{$currency.sign}{($product.price_amount|floatval*$product.minimal_quantity|intval)|number_format:2:'.':','}</span>
                                {/if}
                                {hook h='displayProductPriceBlock' product=$product type='unit_price'}
                                {hook h='displayProductPriceBlock' product=$product type='weight'}
                            </div>
                        {/if}
                        {if $product.quantity >= 1}
                            <div class="qty">
                                {assign var="cantidad_maxima" value=$product.quantity}
                                {foreach $product.features as $feature}
                                    {if $feature.name == 'Cantidad Máxima'}
                                        {assign var="cantidad_maxima" value=$feature.value|escape:'htmlall':'UTF-8'}
                                    {/if}
                                {/foreach}
                                {* value paquetes for quantity *}
                                {foreach $product.features as $feature}
                                    {if $feature.name == 'Paquetes' }
                                        {assign var="paquetes" value={$feature.value}}
                                    {/if}
                                {/foreach}
                                {assign var="paq_exp" value=","|explode:$paquetes}
                                <input
                                    type="hidden"
                                    name="qty"
                                    value="{$product.minimal_quantity}"
                                    class="quantity_wanted input-group"
                                    min="{$product.minimal_quantity}"
                                    max="{$cantidad_maxima}"
                                    aria-label="{l s='Quantity' d='Shop.Theme.Actions'}"
                                />
                                {* Select for packages *}
                                <select name="paquetes" class="select_paq" id="select_paq-{$product.id_product|intval}">
                                    {section name=i loop=$paq_exp}
                                        <option value="{$paq_exp[i]|escape}">{$paq_exp[i]|escape}</option>
                                    {/section}
                                </select>
                            </div>
                        {else}
                            <div class="qty">
                                    <input
                                        type="hidden"
                                        name=""
                                        value="0"
                                        class="quantity_inblock quantity_wanted input-group "
                                        min=""
                                        max=""
                                        disabled="disabled"
                                    />
                                </div>
                        {/if}
                        {if isset($NRT_quickView) && $NRT_quickView}
                            <a href="javascript:void(0)" class="button-action quick-view" data-link-action="quickview" title="{l s='Quick view'}">
                                <i class="zmdi zmdi-filter-center-focus"></i>
                            </a>
                        {/if}
                        {if !isset($is_catalog_mode)}
                            <div style="display: inline-block; text-align: center; width: 100%;">
                                <input type="hidden" name="token" value="{$static_token}">
                                <input type="hidden" name="id_product" value="{$product.id}">
                                {if !$product.quantity && !$product.allow_oosp}
                                    {$product['add_to_cart_url'] = null}
                                {/if}
                                {if $product.customizable == 2 || !empty($product.customization_required)}
                                    {$product['add_to_cart_url'] = null}
                                {/if}
                                {if $product.quantity <= 0}
                                    <button class="button-action icon_block" {if !$product.add_to_cart_url}disabled{/if}>Sin Stock <span class="material-icons">block</span></button>
                                {else}
                                    <button class="button-action buton_dataleyer" data-button-action="add-to-cart" type="submit"> Agregar al carrito <i class="shopping-cart zmdi zmdi-shopping-cart"></i></button>
                                {/if}
                            </div>
                        {/if}

                        {hook h='buttoncompare' product=$product}
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
{* <script type="text/javascript">
    $(document).ready(function() {
        $.each($('.quantity_wanted'), function (index, spinner) {
            var max = $(this).attr("max");
            var min = $(this).attr("min");
            $(spinner).TouchSpin({
                verticalbuttons: false,
                verticalupclass: 'material-icons touchspin-up',
                verticaldownclass: 'material-icons touchspin-down',
                buttondown_class: 'btn btn-touchspin js-touchspin',
                buttonup_class: 'btn btn-touchspin js-touchspin',
                min: min,
                max: max
            });
        });
    });
</script> *}