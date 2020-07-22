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
<div class="product-add-to-cart">
    {if !$configuration.is_catalog}
        {block name='product_quantity'}
            <div class="product-quantity">
                <span class="label-qty control-label title_font">{l s='Qty' d='Shop.Theme.Catalog'}:
                    {assign var="cantidad_maxima" value=$product.quantity}
                    {foreach $product.features as $feature}
                        {if $feature.name == 'Cantidad Máxima'}
                            {assign var="cantidad_maxima" value=$feature.value|escape:'htmlall':'UTF-8'}
                        {/if}
                    {/foreach}
                    <span data-tooltip="{l s='La compra máxima de este producto es de %quantity% unidades' d='Shop.Theme.Catalog' sprintf=['%quantity%' => $cantidad_maxima]}" data-placement="top"><i class="zmdi zmdi-info"></i></span>
                </span>
                {assign var="cantidad_maxima" value=$product.quantity}
                {foreach $product.features as $feature}
                    {if $feature.name == 'Cantidad Máxima'}
                        {assign var="cantidad_maxima" value=$feature.value|escape:'htmlall':'UTF-8'}
                    {/if}
                {/foreach}
                {if $product.quantity >= 1}
                    <div class="qty">
                        <input
                        type="text"
                        name="qty"
                        id="quantity_wanted"
                        value="{$product.quantity_wanted}"
                        class="input-group"
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
                        id="quantity_wanted"
                        value="0"
                        class="input-group quantity_inblock"
                        min="0"
                        max=""
                        disabled="disabled"
                        
                        />
                    </div>  
                {/if}
                <div class="add">
                    {if $product.quantity <= 0}
                        <button class="add-to-cart icon_block " {if !$product.add_to_cart_url}disabled{/if}>Sin Stock <span class="material-icons">block</span></button>
                        {else}
                        <button class="btn btn-primary add-to-cart title_font buton_dataleyer" data-button-action="add-to-cart" type="submit"{if !$product.add_to_cart_url} disabled{/if}>{l s='Add to cart'                        d='Shop.Theme.Actions'} <i class="shopping-cart zmdi zmdi-shopping-cart"></i>
                        </button>
                    {/if}
                </div>
            </div>
        {/block}
        {block name='product_minimal_quantity'}
            <p class="product-minimal-quantity" style="margin:0;">
                {if $product.minimal_quantity > 1}
                    {l
                    s='The minimum purchase order quantity for the product is %quantity%.'
                    d='Shop.Theme.Checkout'
                    sprintf=['%quantity%' => $product.minimal_quantity]
                    }
                {/if}
            </p>
        {/block}
    {/if}
</div>
{hook h='displayProductListFunctionalButtons' product=$product}
{hook h='buttoncompare' product=$product}