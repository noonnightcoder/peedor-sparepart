<div class="row">
    <div class="sidebar-nav" id="client_cart">
        <?php
        if (Common::getCustomerID()!==NULL) {
            $this->widget('yiiwheels.widgets.box.WhBox', array(
                'title' => Yii::t('app', 'Customer Information'),
                'headerIcon' => 'ace-icon fa fa-info-circle ',
                'htmlHeaderOptions' => array('class' => 'widget-header-flat widget-header-small'),
                'content' => $this->renderPartial('partial/_client_selected', array(
                    'model' => $model,
                    'customer_name' => $customer_name,
                    'customer_id' => Common::getCustomerID(),
                    'account' => $account), true),
            ));
        } else {
            $this->widget('yiiwheels.widgets.box.WhBox', array(
                'title' => Yii::t('app', 'Select Customer (Optional)'),
                'headerIcon' => 'ace-icon fa fa-users',
                'htmlHeaderOptions'=>array('class'=>'widget-header-flat widget-header-small'),
                'content' => $this->renderPartial('partial/_client', array('model' => $model), true)
            ));
        }
        ?>
    </div>
</div>