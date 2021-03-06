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
{if isset($nodecontent.products) && $nodecontent.products}
	{if isset($image_type) && isset($image_types[$image_type])}  
        {assign var='imageSize' value=$image_types[$image_type].name}
    {else}
        {assign var='imageSize' value='home_default'}
	{/if}
    {if isset($image_types[{$imageSize}])} 
    	{assign var='width_product' value=$image_types[{$imageSize}].width} 
        {assign var='height_product' value=$image_types[{$imageSize}].height}  
    {else}
        {assign var='width_product' value='auto'} 
        {assign var='height_product' value='auto'}  
    {/if}
    {if isset($image_types[{$imageSize}])}   
    	{assign var='style_padding' value=($image_types[{$imageSize}].height/$image_types[{$imageSize}].width)*100}
    {else}
        {assign var='style_padding' value=100}
    {/if} 
     <div class="products slider_carousel horizontal_mode" data-filter-carousel="{$nodecontent.line_md},{$nodecontent.line_sm},{$nodecontent.line_xs},{$nodecontent.ap},1,{$nodecontent.dt},{$nodecontent.ar},5000,{$nodecontent.line_ms}">
        <div class="owl-carousel owl-theme">
            {assign var="i" value="0"}
            {if isset($nodecontent.colnb) && $nodecontent.colnb}
                {assign var="y" value=$nodecontent.colnb}
            {else}
                {assign var="y" value=1}
            {/if}
            {foreach from=$nodecontent.products item="product"}
                {if $i mod $y eq 0}
                    <div class="item">
                {/if}
                <div class="item-inner hover_second_img">
                    <div class="product-miniature js-product-miniature" data-id-product="{$product.id_product}" data-id-product-attribute="{$product.id_product_attribute}" itemscope itemtype="http://schema.org/Product">
                        <div class="list-functional-buttons">
                            {hook h='displayProductListFunctionalButtons' product=$product}
                            {hook h='displayProductListFunctionalCustomButtons' product=$product}
                        </div>
                        <div class="left-product" style="cursor: pointer;" onclick="window.location='{$product.url}';">
                            <a href="{$product.url}" title="{$product.name}"
                               class="loading_element"
                               style="padding-bottom:{$style_padding}%"
                            >
                                <img
                                    class="{if $nodecontent.line_lg}owl-lazy{/if} img_element"
                                    {if $nodecontent.line_lg}data-{/if}src = "{$product.cover.bySize[{$imageSize}].url}"
                                    {if $nodecontent.line_lg}src="#"{/if}
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
                                    {if $feature.name == 'Sabor'}
                                        <span class="features">Sabor: {$feature.value|escape:'htmlall':'UTF-8'}</span>
                                    {/if}
                                {/foreach}

                                {hook h='displayProductListReviews' product=$product}

                            </div>
                            <div class="content-action-product">
                                <form action="{$urls.pages.cart}" method="post">
                                    {if $product.show_price}
                                        <div class="product-price-and-shipping">
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
                                            <span class="price">{$product.price}</span>
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
                                            <input
                                                type="text"
                                                name="qty"
                                                value="1"
                                                class="quantity_wanted input-group"
                                                min="{$product.minimal_quantity}"
                                                max="{$cantidad_maxima}"
                                                aria-label="{l s='Quantity' d='Shop.Theme.Actions'}"
                                            />
                                        </div>
                                    {else}
                                        <div class="qty">
                                                <input
                                                    type="text"
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
                {assign var="i" value="`$i+1`"}
                {if $i mod $y eq 0 || $i eq count($nodecontent.products)}
                    </div>
                {/if}
            {/foreach}
        </div>
    </div>
{else}
    <p class="alert_no_item">{l s='No products at this time.'}</p>
{/if}
<script type="text/javascript">
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
</script>