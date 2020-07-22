/**
* 2007-2020 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
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
*  @author    PrestaShop SA <contact@prestashop.com>
*  @copyright 2007-2020 PrestaShop SA
*  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*
* Don't forget to prefix your containers with your own identifier
* to avoid any conflicts with others containers.
*/

// Calculator for packages
$.fn.calculator = function() {
    
    var target = $('.product-price-and-shipping.mode-packages');
    if(!target.length) return;

    var lang = $('html').attr('lang');
    // console.log('lang: '+lang);

    var value, pricetxt, price, newprice, newpricetxt, pricetxt2, price2, newprice2, newpricetxt2;
    var currency = target.data('sign');
    var select = $('.select_paq');
    select.on('change', function(){
        value = $(this).val();
        value = parseInt(value);
        //console.log('value: '+value);
        pricetxt = $(this).closest('.content-action-product').find('.product-price-and-shipping').data('price');
        pricetxt2 = $(this).closest('.product-information').find('.product-price-and-shipping').data('price'); //for product page
        // console.log('pricetxt: '+pricetxt);
        price = parseFloat(pricetxt);
        price2 = parseFloat(pricetxt2);
        //console.log('price: '+price);
        $(this).closest('.content-action-product').find('.quantity_wanted').val(value);
        $(this).closest('.product-quantity').find('.quantity_wanted').val(value); //for product page


        //calculate new price
        newprice = price * value;
        newprice2 = price2 * value;
        // value for country
        switch (lang) {
            case 'cb':
                newprice = formatCurrency("es-CO", 0, newprice);
                newprice2 = formatCurrency("es-CO", 0, newprice2);
                // console.log('formatCurrency: '+newprice);
                break;

            case 'mx':
                newprice = formatCurrency("es-MX", 2, newprice);
                newprice2 = formatCurrency("es-MX", 2, newprice2);
                // console.log('formatCurrency: '+newprice);
                break;

            case 'pe':
                newprice = formatCurrency("es-PE", 2, newprice);
                newprice2 = formatCurrency("es-PE", 2, newprice2);
                // console.log('formatCurrency: '+newprice);
                break;
        
            default:
                newprice = parseFloat(newprice).toFixed(2);
                newprice2 = parseFloat(newprice2).toFixed(2);
                // console.log('toFixed: '+newprice);
                break;
        }
        
        newpricetxt = currency+newprice;
        newpricetxt2 = currency+newprice2;
        $(this).closest('.content-action-product').find('.price').text(newpricetxt);
        $(this).closest('.product-information').find('.price').text(newpricetxt2); //for product page
        
    });

}

// $.fn.disabledInput = function() {
    
//     var target = $('#cart .quantity_input');
//         if (!target.length) return;

//     setTimeout(function () {
//        target.attr('disabled', 'disabled');
//     }, 500);

// }

// Function to set currency format
function formatCurrency (locales, fractionDigits, number) {
    var formatted = new Intl.NumberFormat(locales, {
    //   style: 'currency',
    //   currency: currency,
      minimumFractionDigits: fractionDigits
    }).format(number);
    return formatted;
  }

$(document).ready(function() {

    //Calculator
    $('body').calculator();
    $(document).on('click', '.infinitescroll-load-more-bottom a', function(){
        setTimeout(function(){
            $('body').calculator();
        }, 1500);
    });

    // Inputs quantity disabled
    // $('body').disabledInput();
    // $(document).on('click', '#cart .remove-from-cart span, #cart .remove-from-cart, #cart .promo-code button span, #cart .promo-code button', function(){
    //     setTimeout(function(){
    //         console.log('culoanal');
    //         $('body').disabledInput();
    //     }, 1500);
    // });
});
