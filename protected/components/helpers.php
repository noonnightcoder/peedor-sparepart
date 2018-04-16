<?php

function bizName()
{
    return param('biz_name');
}

function bizNameFirstUpper()
{
    return t(ucfirst(param('biz_name')),'app');
}

function bizTitleUcWord()
{
    return t(ucwords(param('biz_title')),'app');
}

function bizWebsite()
{
    return 'http://peedor.com';
}

function bizVision()
{
    return "To bring new exciting experience and creative innovation to all parent business";
}

function companyName()
{
    return param('company_name');
}

function companyNameUpper()
{
    return strtoupper(param('company_name'));
}

function companyNameFirstUpper()
{
    return ucfirst(param('company_name'));
}

function companySlogan()
{
    return param('company_slogan');
}

function companySloganUcwords()
{
    return t(ucwords(param('company_slogan')),'app');
}

function ddmonyyyy()
{
    return date('d M Y');
}

function freeTrialText()
{
    return 'Start Free Trail';
}

function invFolderPath()
{
    return Yii::app()->shoppingCart->getInvoiceFormat();
}

function invIfSaleRep()
{

    if (Yii::app()->settings->get('receipt', 'printSaleRep') == '1') {
        return true;
    }

    return false;
}

function invIfCompanyLogo()
{

    if (Yii::app()->settings->get('receipt', 'printcompanyLogo') == '1') {
        return true;
    }

    return false;
}

function invIfCompanyName()
{

    if (Yii::app()->settings->get('receipt', 'printcompanyName') == '1') {
        return true;
    }

    return false;
}

function invIfCompanyPhone()
{

    if (Yii::app()->settings->get('receipt', 'printcompanyPhone') == '1') {
        return true;
    }

    return false;
}

function invIfCompanyAdd()
{

    if (Yii::app()->settings->get('receipt', 'printcompanyAddress') == '1') {
        return true;
    }

    return false;
}

function invIfCompanyAdd1()
{

    if (Yii::app()->settings->get('receipt', 'printcompanyAddress1') == '1') {
        return true;
    }

    return false;
}

function invIfTransTime()
{

    if (Yii::app()->settings->get('receipt', 'printtransactionTime') == '1') {
        return true;
    }

    return false;
}

function curcurrencySympbol()
{
    return Yii::app()->settings->get('site', 'currencySymbol');
}

function invNumInterval()
{
    return Yii::app()->settings->get('system', 'invoiceNumInterval');
}

function invNumPrefix()
{
    return Yii::app()->settings->get('site', 'invoicePrefix') . date('y') . '-00000';
}


function sysMenuHome()
{
    return strtoupper(t(param('menu_home'), 'app'));
}

function sysMenuDashboard()
{
    return strtoupper(t(param('menu_dashboard'), 'app'));
}

function sysMenuItem()
{
    return strtoupper(t(param('menu_item'), 'app'));
}

function sysMenuItemAdd()
{
    return ucwords(t(param('menu_item_add'), 'app'));
}

function sysMenuAssembliesView()
{
    return ucwords(t(param('menu_asseblies_view'), 'app'));
}

function sysMenuItemView()
{
    return ucwords(t(param('menu_item_view'), 'app'));
}

function sysMenuItemImpExp()
{
    return ucwords(t(param('menu_item_imp_exp'), 'app'));
}

function sysMenuItemAdd2()
{
    return ucwords(t(param('menu_item_add2'), 'app'));
}

function sysMenuItemMarkupPrice()
{
    return ucwords(t(param('menu_item_markup_price'), 'app'));
}

function sysMenuInventory()
{
    return strtoupper(t(param('menu_inventory'), 'app'));
}

function sysMenuInventoryAdd()
{
    return ucwords(t(param('menu_inventory_add'), 'app'));
}

function sysMenuInventoryMinus()
{
    return ucwords(t(param('menu_inventory_minus'), 'app'));
}

function sysMenuInventoryCount()
{
    return ucwords(t(param('menu_inventory_count'), 'app'));
}

function sysMenuInventoryTransfer()
{
    return ucwords(t(param('menu_inventory_transfer'), 'app'));
}

function sysMenuPurchase()
{
    return strtoupper(t(param('menu_purchase'), 'app'));
}

function sysMenuPurchaseReceive()
{
    return ucwords(t(param('menu_purchase_receive'), 'app'));
}

function sysMenuPurchaseReturn()
{
    return ucwords(t(param('menu_purchase_return'), 'app'));
}

function sysMenuPurchasePayment()
{
    return ucwords(t(param('menu_purchase_payment'), 'app'));
}

function sysMenuSale()
{
    return ucwords(t(param('menu_sale'), 'app'));
}

function sysMenuSaleOrder()
{
    return ucwords(t(param('menu_sale_order'), 'app'));
}

function sysMenuSaleOrderAdd()
{
    return ucwords(t(param('menu_sale_order_add'), 'app'));
}

function sysMenuSaleOrderView()
{
    return ucwords(t(param('menu_sale_order_view'), 'app'));
}

function sysMenuInvoicing()
{
    return ucwords(t(param('menu_invoicing'), 'app'));
}

function sysMenuSaleOrderToValidate()
{
    return ucwords(t(param('menu_sale_order_to_validate'), 'app'));
}

function sysMenuSaleOrderToInvoice()
{
    return ucwords(t(param('menu_sale_order_to_invoice'), 'app'));
}

function sysMenuSaleOrderToDeliver()
{
    return ucwords(t(param('menu_sale_order_to_deliver'), 'app'));
}

function sysMenuSaleAdd()
{
    return ucwords(t(param('menu_sale_add'), 'app'));
}

function sysMenuSaleView()
{
    return ucwords(t(param('menu_sale_view'), 'app'));
}

function sysMenuSaleApprove()
{
    return ucwords(t(param('menu_sale_approve'), 'app'));
}

function sysMenuSalePayment()
{
    return ucwords(t(param('menu_sale_payment'), 'app'));
}

function sysMenuInvoice()
{
    return ucwords(t(param('menu_invoicing'), 'app'));
}

function sysMenuReport()
{
    return ucwords(t(param('menu_report'), 'app'));
}

function sysMenuAboutUS()
{
    return ucwords(t(param('menu_about_us'), 'app'));
}

function sysMenuCustomer()
{
    return ucwords(t(param('menu_customer'), 'app'));
}

function sysMenuEmployee()
{
    return ucwords(t(param('menu_employee'), 'app'));
}

function sysMenuSupplier()
{
    return ucwords(t(param('menu_supplier'), 'app'));
}

function sysMenuAuthorization()
{
    return ucwords(t(param('menu_authorization'), 'app'));
}

function sysMenuSetting()
{
    return strtoupper(t(param('menu_setting'), 'app'));
}

function sysMenuCategory()
{
    return ucwords(t(param('menu_category'), 'app'));
}

function sysMenuPriceTier()
{
    return ucwords(t(param('menu_price_tier'), 'app'));
}

function sysMenuSaleIcon()
{
    return 'fa fa-usd';
}

function sysMenuSaleAddIcon()
{
    return 'fa fa-plus pink';
}

function sysMenuSaleViewIcon()
{
    return 'fa fa-eye pink';
}

function sysMenuSalePaymentIcon()
{
    return 'fa fa-heart';
}

function sysMenuInvoiceIcon()
{
    return 'fa fa-usd';
}

function sysMenuItemIcon()
{
    return 'fa fa-coffee';
}

function sysMenuHomeIcon()
{
    return 'fa fa-home';
}

function sysMenuDashboardIcon()
{
    return 'fa fa-tachometer';
}

function sysMenuInventoryIcon()
{
    return 'fa fa-desktop';
}

function sysMenuInventoryAddIcon()
{
    return 'fa fa-plus pink';
}

function sysMenuInventoryMinusIcon()
{
    return 'fa fa-minus';
}

function sysMenuInventoryCountIcon()
{
    return 'fa fa-list-ol purple';
}

function sysMenuInventoryTransferIcon()
{
    return 'fa fa-exchange';
}

function sysMenuPurchaseIcon()
{
    return 'fa fa-money';
}

function sysMenuPurchaseReceiveIcon()
{
    return 'fa fa-plus pink';
}

function sysMenuPurchaseReturnIcon()
{
    return 'fa fa-minus';
}

function sysMenuPurchasePaymentIcon()
{
    return 'fa fa-credit-card';
}

function sysMenuReportIcon()
{
    return 'fa fa-signal';
}

function sysMenuReportSaleIcon()
{
    return 'fa fa-eur green';
}

function sysMenuReportAccountIcon()
{
    return 'fa fa-balance-scale';
}

function sysMenuReportStockIcon()
{
    return 'fa fa-cubes';
}

function sysMenuCustomerIcon()
{
    return 'fa fa-user';
}

function sysMenuEmployeeIcon()
{
    return 'fa fa-user';
}

function sysMenuSupplierIcon()
{
    return 'fa fa-user';
}

function sysMenuAuthorizationIcon()
{
    return 'fa fa-tasks';
}

function sysMenuSettingIcon()
{
    return 'fa fa-cogs';
}

function sysMenuCategoryIcon()
{
    return 'fa fa-list';
}

function sysMenuPriceTierIcon()
{
    return 'fa fa-adjust';
}

function sysMenuSaleOrderToDeliverIcon()
{
    return 'fa fa-truck';
}

function sysMenuSaleOrderIcon()
{
    return 'fa fa-cart-arrow-down';
}

function sysMenuSaleOrderToValidateIcon()
{
    return 'fa fa-check-square-o';
}

function sysMenuSaleOrderInvoiceIcon()
{
    return 'fa fa-paper-plane-o';
}

function getTransType()
{
    return Yii::app()->shoppingCart->getMode();
}

function getEmployeeId()
{
    return Yii::app()->session['employeeid'];
}

function sysFormatNumberDecimal($value)
{
    return number_format($value, Common::getDecimalPlace());
}


