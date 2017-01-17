<?php $box = $this->beginWidget('yiiwheels.widgets.box.WhBox',array(
    'title'         =>  Yii::t('app','Wholesale Register'),
    'headerIcon'    => 'menu-icon fa fa-shopping-cart',
    'headerButtons' => array(
        TbHtml::buttonGroup(
            array(
                array('label' => Yii::t('app','On-going Sale'),'url' =>Yii::app()->createUrl('wholeSale/ListSuspendedSale/'),'icon'=>'ace-icon fa fa-spinner fa-spin white'),
                array('label'=>' | '),
                array('label' => Yii::t('app','New Item'),'url' =>Yii::app()->createUrl('Item/createImage',array('grid_cart'=>'S')),'icon'=>'ace-icon fa fa-plus white'),
            ),array('color'=>TbHtml::BUTTON_COLOR_PRIMARY,'size'=>TbHtml::BUTTON_SIZE_SMALL)
        ),
    ),
    'htmlHeaderOptions'=>array('class'=>'widget-header-flat widget-header-small'),
));
?>

    <div class="widget-main">
        <div id="itemlookup">
            <?php $form=$this->beginWidget('bootstrap.widgets.TbActiveForm',array(
                'action'=>Yii::app()->createUrl('wholeSale/add'),
                'method'=>'post',
                'layout'=>TbHtml::FORM_LAYOUT_HORIZONTAL,
                'id'=>'add_item_form',
            )); ?>

            <?php
            $this->widget('zii.widgets.jui.CJuiAutoComplete', array(
                'model' => $model,
                'attribute' => 'item_id',
                'source' => $this->createUrl('request/suggestItem'),
                //'scriptFile'=>'',
                //'scriptUrl'=> Yii::app()->theme->baseUrl.'/js/',
                'htmlOptions' => array(
                    'size' => '40'
                ),
                'options' => array(
                    'showAnim' => 'fold',
                    'minLength' => '1',
                    'delay' => 10,
                    'autoFocus' => false,
                    'select' => 'js:function(event, ui) {
                        event.preventDefault();
                        $("#SaleItem_item_id").val(ui.item.id);
                        $("#add_item_form").ajaxSubmit({target: "#register_container", beforeSubmit: salesBeforeSubmit, success: itemScannedSuccess});
                    }',
                    //'search' => 'js:function(){ $(".waiting").show(); }',
                    //'open' => 'js:function(){ $(".waiting").hide(); }',
                ),
            ));
            ?>

            <?php /* echo TbHtml::linkButton('',array(
            'color'=>TbHtml::BUTTON_COLOR_INFO,
            'size'=>TbHtml::BUTTON_SIZE_SMALL,
            'icon'=>'glyphicon-hand-up white',
            'url'=>$this->createUrl('Item/SelectItem/'),
            'class'=>'update-dialog-open-link',
            'data-update-dialog-title' => Yii::t('app','select items'),
        )); */ ?>

            <?php $this->endWidget(); ?>
        </div>
    </div>

<?php $this->endWidget(); ?>