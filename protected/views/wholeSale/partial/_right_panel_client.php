<div class="row">
    <div class="sidebar-nav" id="client_cart">
        <?php
        if ($account!==null) {
            $this->widget('yiiwheels.widgets.box.WhBox', array(
                'title' => Yii::t('app', 'Customer Information'),
                'headerIcon' => 'ace-icon fa fa-info-circle ',
                'htmlHeaderOptions'=>array('class'=>'widget-header-flat widget-header-small'),
                'content' => $this->renderPartial('partial/_client_selected', array('model' => $model, 'account' => $account,'customer_id'=>$customer_id), true),
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