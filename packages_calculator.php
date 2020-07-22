<?php
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
*/

if (!defined('_PS_VERSION_')) {
    exit;
}

class Packages_calculator extends Module
{
    protected $config_form = false;

    public function __construct()
    {
        $this->name = 'packages_calculator';
        $this->tab = 'front_office_features';
        $this->version = '1.0.0';
        $this->author = 'Alekuoshu';
        $this->need_instance = 1;

        /**
         * Set $this->bootstrap to true if your module is compliant with bootstrap (PrestaShop 1.6)
         */
        $this->bootstrap = true;

        parent::__construct();

        $this->displayName = $this->l('Packages and Calculator');
        $this->description = $this->l('This module if for change way for show quantities in frontend, like packages and calculator');

        $this->confirmUninstall = $this->l('Are you sure want unistall this module?');

        $this->ps_versions_compliancy = array('min' => '1.7', 'max' => _PS_VERSION_);
    }

    /**
     * Don't forget to create update methods if needed:
     * http://doc.prestashop.com/display/PS16/Enabling+the+Auto-Update
     */
    public function install()
    {
        Configuration::updateValue('PACKAGES_CALCULATOR_LIVE_MODE', false);

        return parent::install() &&
            $this->registerHook('header') &&
            $this->registerHook('backOfficeHeader') &&
            $this->registerHook('displayBackOfficeHeader') &&
            $this->registerHook('displayHeader') &&
            $this->registerHook('displayHome');
    }

    public function uninstall()
    {
        Configuration::deleteByName('PACKAGES_CALCULATOR_LIVE_MODE');

        // delete packages files
        $this->removeRequireFiles();

        return parent::uninstall();
    }

    /**
     * Copy some files to current theme
     */
    public function copyCustomFiles($from, $to)
    {
        //Abro el directorio que voy a leer
        $dir = opendir($from);
        //Recorro el directorio para leer los archivos que tiene
        while(($file = readdir($dir)) !== false){
            if(strpos($file, '.') !== 0){
                //Copio el archivo manteniendo el mismo nombre en la nueva carpeta
                $success = copy($from.$file, $to.$file);
            }
        }

        closedir($dir);

    }

    /**
     * Add requiere files
     */
    public function addRequireFiles()
    {
        // copy some custom tpl to current theme
        // product-home-slider.tpl - Home
        $from = _PS_MODULE_DIR_.'/packages_calculator/assets/packages/templates/';
        $to = _PS_ROOT_DIR_._PS_THEME_URI_.'templates/';
        $this->copyCustomFiles($from, $to);

        // product.tpl - Category
        $from = _PS_MODULE_DIR_.'/packages_calculator/assets/packages/catalog_partials_miniatures/';
        $to = _PS_ROOT_DIR_._PS_THEME_URI_.'templates/catalog/_partials/miniatures/';
        $this->copyCustomFiles($from, $to);

        // product.tpl and product-add-to-cart.tpl- Product Page
        $from = _PS_MODULE_DIR_.'/packages_calculator/assets/packages/catalog_partials/';
        $to = _PS_ROOT_DIR_._PS_THEME_URI_.'templates/catalog/_partials/';
        $this->copyCustomFiles($from, $to);

        // cart-detailed-product-line.tpl- Cart Page
        $from = _PS_MODULE_DIR_.'/packages_calculator/assets/packages/templates_checkout_partials/';
        $to = _PS_ROOT_DIR_._PS_THEME_URI_.'templates/checkout/_partials/';
        $this->copyCustomFiles($from, $to);


    }

    /**
     * Remove requiere files
     */
    public function removeRequireFiles()
    {
        // delete some custom tpl from current theme
         // product-home-slider.tpl - Home
        unlink(_PS_ROOT_DIR_._PS_THEME_URI_.'templates/product-home-slider.tpl');
        $from = _PS_MODULE_DIR_.'/packages_calculator/assets/origin/templates/';
        $to = _PS_ROOT_DIR_._PS_THEME_URI_.'templates/';
        $this->copyCustomFiles($from, $to);

        // product.tpl - Category
        unlink(_PS_ROOT_DIR_._PS_THEME_URI_.'templates/catalog/_partials/miniatures/product.tpl');
        $from = _PS_MODULE_DIR_.'/packages_calculator/assets/origin/catalog_partials_miniatures/';
        $to = _PS_ROOT_DIR_._PS_THEME_URI_.'templates/catalog/_partials/miniatures/';
        $this->copyCustomFiles($from, $to);

        // product-prices.tpl and product-add-to-cart.tpl- Product Page
        unlink(_PS_ROOT_DIR_._PS_THEME_URI_.'templates/catalog/_partials/product-prices.tpl');
        unlink(_PS_ROOT_DIR_._PS_THEME_URI_.'templates/catalog/_partials/product-add-to-cart.tpl');
        $from = _PS_MODULE_DIR_.'/packages_calculator/assets/origin/catalog_partials/';
        $to = _PS_ROOT_DIR_._PS_THEME_URI_.'templates/catalog/_partials/';
        $this->copyCustomFiles($from, $to);

        // cart-detailed-product-line.tpl- Cart Page
        unlink(_PS_ROOT_DIR_._PS_THEME_URI_.'templates/checkout/_partials/cart-detailed-product-line.tpl');
        $from = _PS_MODULE_DIR_.'/packages_calculator/assets/origin/templates_checkout_partials/';
        $to = _PS_ROOT_DIR_._PS_THEME_URI_.'templates/checkout/_partials/';
        $this->copyCustomFiles($from, $to);

    }

    /**
     * Load the configuration form
     */
    public function getContent()
    {
        /**
         * If values have been submitted in the form, process.
         */
        $output = '';
        if (((bool)Tools::isSubmit('submitPackages_calculatorModule')) == true) {
            $output = $this->displayConfirmation($this->l('Settings updated'));
            $this->postProcess();
            // var_dump(_PS_THEME_URI_);
            // active functionality
            $active = Tools::getValue('PACKAGES_CALCULATOR_LIVE_MODE');
            if($active){
                $this->addRequireFiles();
            }else{
                $this->removeRequireFiles();
            }
            
        }

        $this->context->smarty->assign('module_dir', $this->_path);

        $output .= $this->context->smarty->fetch($this->local_path.'views/templates/admin/configure.tpl');

        return $output.$this->renderForm();
    }

    /**
     * Create the form that will be displayed in the configuration of your module.
     */
    protected function renderForm()
    {
        $helper = new HelperForm();

        $helper->show_toolbar = false;
        $helper->table = $this->table;
        $helper->module = $this;
        $helper->default_form_language = $this->context->language->id;
        $helper->allow_employee_form_lang = Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG', 0);

        $helper->identifier = $this->identifier;
        $helper->submit_action = 'submitPackages_calculatorModule';
        $helper->currentIndex = $this->context->link->getAdminLink('AdminModules', false)
            .'&configure='.$this->name.'&tab_module='.$this->tab.'&module_name='.$this->name;
        $helper->token = Tools::getAdminTokenLite('AdminModules');

        $helper->tpl_vars = array(
            'fields_value' => $this->getConfigFormValues(), /* Add values for your inputs */
            'languages' => $this->context->controller->getLanguages(),
            'id_language' => $this->context->language->id,
        );

        return $helper->generateForm(array($this->getConfigForm()));
    }

    /**
     * Create the structure of your form.
     */
    protected function getConfigForm()
    {
        return array(
            'form' => array(
                'legend' => array(
                'title' => $this->l('Settings'),
                'icon' => 'icon-cogs',
                ),
                'input' => array(
                    array(
                        'type' => 'switch',
                        'label' => $this->l('Packages On'),
                        'name' => 'PACKAGES_CALCULATOR_LIVE_MODE',
                        'is_bool' => true,
                        'desc' => $this->l('On/Off the functionality for packages'),
                        'values' => array(
                            array(
                                'id' => 'active_on',
                                'value' => true,
                                'label' => $this->l('Enabled')
                            ),
                            array(
                                'id' => 'active_off',
                                'value' => false,
                                'label' => $this->l('Disabled')
                            )
                        ),
                    ),
                ),
                'submit' => array(
                    'title' => $this->l('Save'),
                ),
            ),
        );
    }

    /**
     * Set values for the inputs.
     */
    protected function getConfigFormValues()
    {
        return array(
            'PACKAGES_CALCULATOR_LIVE_MODE' => Configuration::get('PACKAGES_CALCULATOR_LIVE_MODE', true),
            // 'PACKAGES_CALCULATOR_ACCOUNT_EMAIL' => Configuration::get('PACKAGES_CALCULATOR_ACCOUNT_EMAIL', 'contact@prestashop.com'),
            // 'PACKAGES_CALCULATOR_ACCOUNT_PASSWORD' => Configuration::get('PACKAGES_CALCULATOR_ACCOUNT_PASSWORD', null),
        );
    }

    /**
     * Save form data.
     */
    protected function postProcess()
    {
        $form_values = $this->getConfigFormValues();

        foreach (array_keys($form_values) as $key) {
            Configuration::updateValue($key, Tools::getValue($key));
        }
    }

    /**
    * Add the CSS & JavaScript files you want to be loaded in the BO.
    */
    public function hookBackOfficeHeader()
    {
        // if (Tools::getValue('module_name') == $this->name) {
        //     $this->context->controller->addJS($this->_path.'views/js/back.js');
        //     $this->context->controller->addCSS($this->_path.'views/css/back.css');
        // }
    }

    /**
     * Add the CSS & JavaScript files you want to be added on the FO.
     */
    public function hookHeader()
    {
        $active = Configuration::get('PACKAGES_CALCULATOR_LIVE_MODE');
        if($active){
            $this->context->controller->addJS($this->_path.'views/js/front.js');
            $this->context->controller->addCSS($this->_path.'views/css/front.css');
        }
    }

    // public function hookDisplayHeader()
    // {
    //     $this->context->controller->addJS($this->_path.'views/js/front.js');
    //     $this->context->controller->addCSS($this->_path.'views/css/front.css');
    // }

    public function hookDisplayBackOfficeHeader()
    {
        /* Place your code here. */
    }

    public function hookDisplayHome()
    {
        /* Place your code here. */
    }
}
