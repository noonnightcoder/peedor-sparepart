<div id="register_container">

<div class="col-xs-12 col-sm-8 widget-container-col">
    <div class="message expire_date" style="display:none">
        <div class="alert in alert-block fade alert-success">Transaction Failed !</div>
    </div>
    
    <?php $this->renderPartial('_search', array('model' => $model,'first_load'=>$first_load)); ?>

    <!-- #section:grid.cart.layout -->
    <div class="grid-view" id="grid_cart">  
        
        <?php
        if (isset($warning)) {
            echo TbHtml::alert(TbHtml::ALERT_COLOR_INFO, $warning);
        }
        ?>
        <table class="table table-hover table-condensed">
            <thead>
                <tr><th><?php echo Yii::t('app', 'Item Name'); ?></th>
                    <th><?php echo Yii::t('app', 'Price'); ?></th>
                    <th><?php echo Yii::t('app', 'Quantity'); ?></th>
                    <th class="<?php echo Yii::app()->settings->get('sale', 'discount'); ?>"><?php echo Yii::t('app', 'Discount'); ?></th>
                    <th><?php echo Yii::t('app', 'Total'); ?></th>
                    <th></th>
                </tr>
            </thead>
            <tbody id="cart_contents">
                <?php foreach (array_reverse($items, true) as $id => $item): ?>
                        <?php
                            $total_item = Common::calDiscount($item['discount'],$item['price'],$item['quantity']);
                            $item_id = $item['item_id'];
                            $cur_item_info = Item::model()->findbyPk($item_id);
                            $qty_in_stock = $cur_item_info->quantity;
                        ?>
                        <tr>
                            <td> 
                                <?php echo $item['name']; ?><br/>
                                <span class="text-info"><?php echo $qty_in_stock . ' ' . Yii::t('app', 'in stock') ?> </span>
                            </td>
                            <td>
                                <?php $form=$this->beginWidget('bootstrap.widgets.TbActiveForm',array(
                                        'method'=>'post',
                                        'action' => Yii::app()->createUrl('wholeSale/editItem/',array('item_id'=>$item['item_id'])),
                                        'htmlOptions'=>array('class'=>'line_item_form'),
                                        //'layout'=>TbHtml::FORM_LAYOUT_INLINE,
                                    ));
                                ?>                                
                                    <span class="input-icon">
                                    <?php echo $form->textField($model, "price", array('value' => $item['price'], 
                                                'class' => 'input-small input-grid', 
                                                'id' => "price_$item_id", 
                                                'placeholder' => 'Price', 
                                                'maxlength' => 10,
                                                'disabled'=>$disable_editprice,
                                                //'htmlOptions' => '<i',
                                            )
                                       ); 
                                    ?>
                                    <i class="ace-icon blue"><?php echo $item['currency_symbol']; ?> </i>    
                                    <span class="input-icon">    
                                <?php $this->endWidget(); ?>   
                            </td>
                                 
                            <td>
                                <?php $form=$this->beginWidget('bootstrap.widgets.TbActiveForm',array(
                                        'method'=>'post',
                                        'action' => Yii::app()->createUrl('wholeSale/editItem/',array('item_id'=>$item['item_id'])),
                                        'htmlOptions'=>array('class'=>'line_item_form'),
                                    ));
                                ?>
                                    <?php echo $form->textField($model, "quantity", array('value' => $item['quantity'], 
                                            'class' => 'input-small input-grid', 
                                            'id' => "quantity_$item_id", 
                                            'placeholder' => 'Quantity',
                                            'maxlength' => 10)
                                        ); ?>
                                <?php $this->endWidget(); ?>
                            </td>
                            <td class="<?php echo Yii::app()->settings->get('sale', 'discount'); ?>">
                                <?php $form=$this->beginWidget('bootstrap.widgets.TbActiveForm',array(
                                        'method'=>'post',
                                        'action' => Yii::app()->createUrl('wholeSale/editItem/',array('item_id'=>$item['item_id'])),
                                        'htmlOptions'=>array('class'=>'line_item_form'),
                                    ));
                                ?>
                                <?php echo $form->textField($model, "discount", array('value' => $item['discount'], 
                                                'class' => 'input-small input-grid', 'id' => 
                                                "discount_$item_id", 
                                                'placeholder' => 'Discount', 
                                                'data-id' => "$item_id", 
                                                'maxlength' => 9,
                                                'disabled'=>$disable_discount,
                                            )
                                       ); 
                                ?>
                                <?php $this->endWidget(); ?>    
                            </td>
                            <td><?php echo $total_item; ?>
                            <td><?php
                                echo TbHtml::linkButton('', array(
                                    'color'=>TbHtml::BUTTON_COLOR_DANGER,
                                    'size' => TbHtml::BUTTON_SIZE_MINI,
                                    'icon' => 'glyphicon glyphicon-trash ',
                                    'url' => array('DeleteItem', 'item_id' => $item_id),
                                    'class' => 'delete-item',
                                    'title' => Yii::t('app', 'Remove'),
                                ));
                                ?>
                            </td>    
                        </tr>    
                <?php endforeach; ?> <!--/endforeach-->

            </tbody>
        </table>


        <?php
        if (empty($items)) {
            echo Yii::t('app', 'There are no items in the cart');
        }
        ?>

        <?php if (!empty($items)) { ?>
          <div class="widget-toolbox padding-8 clearfix">
            <div class="col-xs-8"></div>  
            <div class="col-xs-4" id="total_discount_cart">
                <?php $form=$this->beginWidget('bootstrap.widgets.TbActiveForm',array(
                        'method'=>'post',
                        'action' => Yii::app()->createUrl('wholeSale/setTotalDiscount/'),
                        'id'=>'total_discount_form'
                    ));
                ?>
                    <?php echo $form->textField($model,'total_discount',array(
                            'id'=>'total_discount_id',
                            'class'=>'col-xs-12 input-totaldiscount',
                            'placeholder'=>'Total Discount',
                            'maxlength'=>25,
                            'append' => '%',
                            'disabled' => $disable_discount
                          )
                    ); ?>
                <?php $this->endWidget(); ?>
            </div>
          </div>
         <?php } ?>
        
    </div> <!-- #section:grid.cart.layout -->

    <i class="ace-icon fa fa-book"></i>
    <?php echo TbHtml::tooltip('Keyboard Shortcuts Help','#',
            '[ESC] => Set the focus to the "Cancel Sale". [Enter] will trigger the functionality <br>
             [F1] => Set the focus to "Payment Amount" [Enter] to make payment, Press another [Enter] to Complete Sale',
             array('data-html' => 'true','placement' => TbHtml::TOOLTIP_PLACEMENT_TOP,)
    ); ?>   

</div> <!--/span8-->

<div class="col-xs-12 col-sm-4 widget-container-col">
    <!-- #section:canel-cart.layout -->
    <div class="row">
        <div id="cancel_cart">
            <?php if ($count_item <> 0) { ?> 
                <?php
                $form = $this->beginWidget('bootstrap.widgets.TbActiveForm', array(
                    'id' => 'suspend_sale_form',
                    'action' => Yii::app()->createUrl('wholeSale/SuspendSale/'),
                    'enableAjaxValidation' => false,
                    'layout' => TbHtml::FORM_LAYOUT_INLINE,
                ));
                ?>
                    <div align="right">
                        <?php
                        echo TbHtml::linkButton(Yii::t('app', 'Save Sale'), array(
                            'color' => TbHtml::BUTTON_COLOR_INFO,
                            'size' => TbHtml::BUTTON_SIZE_SMALL,
                            'icon' => 'ace-icon fa fa-save white',
                            'url' => Yii::app()->createUrl('wholeSale/SuspendSale/'),
                            'class' => 'suspend-sale',
                            //'title' => Yii::t('app', 'Suspend Sale'),
                        ));
                        ?>

                        <?php
                        echo TbHtml::linkButton(Yii::t('app', 'Cancel Sale'), array(
                            'color' => TbHtml::BUTTON_COLOR_DANGER,
                            'size' => TbHtml::BUTTON_SIZE_SMALL,
                            'icon' => '	glyphicon-remove white',
                            'url' => Yii::app()->createUrl('wholeSale/CancelSale/'),
                            'class' => 'cancel-sale',
                            'id' => 'cancel_sale_button',
                            //'title' => Yii::t('app', 'Cancel Sale'),
                        ));
                        ?>     
                    </div>
                <?php $this->endWidget(); ?>  
            <?php } ?>
        </div>    
    </div> <!-- #section:canel-cart.layout -->

    <!-- #section:client.layout -->
    <div class="row">
        <div class="sidebar-nav" id="client_cart">
            <?php
            if ($account!==null) {
                $this->widget('yiiwheels.widgets.box.WhBox', array(
                    'title' => Yii::t('app', 'Customer Information'),
                    'headerIcon' => 'ace-icon fa fa-info-circle ',
                    'htmlHeaderOptions'=>array('class'=>'widget-header-flat widget-header-small'),
                    'content' => $this->renderPartial('_client_selected', array('model' => $model, 'account' => $account,'customer_id'=>$customer_id), true),
                ));
            } else {
                $this->widget('yiiwheels.widgets.box.WhBox', array(
                    'title' => Yii::t('app', 'Select Customer (Optional)'),
                    'headerIcon' => 'ace-icon fa fa-users',
                    'htmlHeaderOptions'=>array('class'=>'widget-header-flat widget-header-small'),
                    'content' => $this->renderPartial('_client', array('model' => $model), true)
                ));
            }
            ?>
        </div>  
    </div> <!-- #section:client.layout -->

    <!-- #section:payment-cart.layout -->
    <div class="row">
        <div class="sidebar-nav" id="payment_cart">
            <?php if ($count_item <> 0) { ?>    
                    <?php
                    $form = $this->beginWidget('bootstrap.widgets.TbActiveForm', array(
                        'id' => 'finish_sale_form',
                        'action' => Yii::app()->createUrl('wholeSale/completeSale/'),
                        'enableAjaxValidation' => false,
                        'layout' => TbHtml::FORM_LAYOUT_INLINE,
                    ));
                    ?>
                        <table class="table table-bordered table-condensed">
                            <tbody>
                                <tr>
                                    <td><?php echo Yii::t('app', 'Item in Cart'); ?> :</td>
                                    <td><?php echo $count_item; ?></td>
                                </tr>
                                
                                <?php if ($total_discount!==NULL && $total_discount>0) { ?>
                                <?php foreach ($sub_total_mc as $id => $subtotalmc): ?>   
                                    <tr>
                                        <td><?php echo Yii::t('app', 'Sub Total in ') . $subtotalmc["currency_id"]  ; ?> :</td>
                                        <td>
                                            <span class="badge badge-success bigger-120">
                                                <?php echo $subtotalmc['currency_symbol']. $subtotalmc["total"]; ?>  
                                            </span>
                                        </td>
                                    </tr>
                                <?php endforeach; ?> 
                                <?php } ?>
                                
                                <?php foreach ($total_mc as $id => $totalmc): ?>   
                                    <tr>
                                        <td><?php echo Yii::t('app', 'Total in ') . $totalmc["currency_id"]  ; ?> :</td>
                                        <td>
                                            <span class="badge badge-primary bigger-120">
                                                <?php echo $totalmc['currency_symbol']. $totalmc["total"]; ?>  
                                            </span>
                                        </td>
                                    </tr>
                                <?php endforeach; ?> 
                                    
                                <?php if ($count_payment > 0) { ?>
                                    <?php foreach ($payments as $id => $payment): ?>
                                    <tr>
                                        <td>
                                            <?php
                                            echo TbHtml::linkButton('', array(
                                                'size' => TbHtml::BUTTON_SIZE_MINI,
                                                'color' => TbHtml::BUTTON_COLOR_DANGER,
                                                'icon' => 'glyphicon-remove',
                                                'url' => Yii::app()->createUrl('wholeSale/DeletePayment', array('currency_code' => $payment['currency_code'])),
                                                'class' => 'delete-payment pull-right',
                                                'title' => Yii::t('app', 'Delete Payment'),
                                            ));
                                            ?>  
                                            <?php echo Yii::t('App','Paid Amount') . ' [' . $payment['currency_symbol'] .']'; ?></td>
                                        <td>
                                            <span class="badge badge-info bigger-120">
                                                <?php echo $payment['currency_symbol']  . $payment['payment_amount']; ?>
                                            </span>
                                        </td>
                                    </tr>
                                    <?php endforeach; ?>
                                                           
                                <?php } ?>
                                    
                                <?php if ($account!==null) { ?>    
                                    <?php foreach ($total_due as $id => $totaldue): ?>   
                                        <tr>
                                            <td><?php echo TbHtml::b(Yii::t('app', 'Outstanding in ') . $totaldue["currency_id"])  ; ?> :</td>
                                            <td>
                                                <span class="badge badge-success bigger-140">
                                                    <?php echo $totaldue['currency_symbol']. $totaldue["total"]; ?>  
                                                </span>
                                            </td>
                                        </tr>
                                    <?php endforeach; ?>     
                                <?php } ?>    
                                                
                                <tr style="display: none;">
                                    <td><?php //echo Yii::t('app', 'Payment Type'); ?>:</td>
                                    <td>
                                        <?php //echo $form->dropDownList($model, 'payment_type', InvoiceItem::itemAlias('payment_type'), array('id' => 'payment_type_id')); ?> 
                                    </td>
                                </tr>
                                
                                <?php if ($count_payment == 0 || $count_payment == 1 || $count_payment == 2  ) { ?>
                                    <tr>
                                        <td> 
                                            <?php echo $form->dropDownList($model,'payment_type', CurrencyType::model()->getCurrency(),array(
                                                            'id'=>'currency_type_id',
                                                            'options'=>array($selected_currency->code=>array('selected'=>true)),
                                                            'class'=>'col-xs-10 col-sm-8')
                                            ); ?>
                                        </td>
                                        <td style='text-align:right'>
                                        <span class="input-icon">    
                                            <?php echo $form->textFieldControlGroup($model, 'payment_amount', array(
                                                    'class' => 'input-small text-right payment-amount-txt',
                                                    'id' => 'payment_amount_id', 
                                                    'data-url' => Yii::app()->createUrl('wholeSale/AddPayment/'),
                                                    'placeholder'=>Yii::t('app','Payment Amount') . ' ' . $selected_currency->currency_symbol,
                                                )); 
                                            ?> 
                                             <i class="ace-icon fa fa-money green"><?php echo $selected_currency->currency_symbol; ?></i>
                                        </span>
                                        </td>
                                    </tr>
                                
                                
                                    <!--
                                    <tr>
                                        <td colspan="2" style='text-align:right'>
                                            <?php //foreach ($currency_type as $currency) { ?>
                                                <span class="input-icon">
                                                    <?php /* echo $form->textFieldControlGroup($model, 'payment_amount', array(
                                                        'class' => 'input-small text-right payment-amount-txt',
                                                        //'id' => strtolower($currency["currency_id"]) . '_payment_amount_id', 
                                                        'id' => 'payment_amount_' . $currency["code"],
                                                        'data-url' => Yii::app()->createUrl('wholeSale/AddPayment/'),
                                                        'placeholder'=>Yii::t('app','Payment Amount') . ' ' .  $currency["currency_symbol"],
                                                        //'prepend' => $currency["currency_symbol"],
                                                        )); 
                                                     * 
                                                     */
                                                    ?> 
                                                    <i class="ace-icon fa fa-money green"><?php //echo $currency["currency_symbol"]; ?></i>
                                                </span>
                                            
                                            <?php //} ?>
                                        </td>
                                    </tr> 
                                    -->
                                    
                                    <tr>
                                        <td colspan="2" style='text-align:right'><?php
                                            echo TbHtml::linkButton(Yii::t('app', 'Add Payment'), array(
                                                'color' => TbHtml::BUTTON_COLOR_INFO,
                                                'size' => TbHtml::BUTTON_SIZE_MINI,
                                                'icon' => 'glyphicon-plus white',
                                                'url' => Yii::app()->createUrl('wholeSale/AddPayment/'),
                                                'class' => 'add-payment',
                                                //'title' => Yii::t('app', 'Add Payment'),
                                            ));
                                            ?>   
                                        </td>
                                    </tr>
                                <?php } ?>
                                    
                            </tbody>
                        </table>

                        <?php if ($count_payment > 0) { ?>
                            <table class="table table-striped table-condensed">
                                <?php //if ($amount_change<=0) { ?>
                                    <td colspan="3" style='text-align:right'>
                                    <?php
                                    echo TbHtml::linkButton(Yii::t('app', 'Complete Sale'), array(
                                        'color' => TbHtml::BUTTON_COLOR_SUCCESS,
                                        'icon' => 'glyphicon glyphicon-off white',
                                        'class' => 'complete-sale',
                                        'id' => 'finish_sale_button',
                                        //'title' => Yii::t('app', 'Complete Sale'),
                                    ));
                                    ?>        
                                    </td>    
                                    <!--
                                    <div id="comment_content" align="right">
                                    <?php //echo $form->textArea($model,'comment',array('rows'=>1, 'cols'=>20,'class'=>'input-small','maxlength'=>250,'id'=>'comment_id'));  ?>
                                    </div>
                                    -->
                                <?php //} ?>
                            </table>
                    <?php } ?>

                <?php $this->endWidget(); ?> 
             <?php } ?>    
            
        </div> <!-- /section:custom/widget-main -->    
        
    </div> <!-- payment cart -->
 </div> <!-- #section:payment-cart.layout -->


<div class="waiting"><!-- Place at bottom of page --></div>
