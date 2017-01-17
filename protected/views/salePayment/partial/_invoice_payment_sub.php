<?php $this->widget('bootstrap.widgets.TbTabs', array(
    'type'=>'tabs',
    'placement'=>'above', // 'above', 'right', 'below' or 'left'
    'tabs'=>array(
        array('label'=>Yii::t('app','Outstanding Invoice'),'id'=>'tab_1', 'content'=>$this->renderPartial('partial/_invoice', array('model'=>$model,'client_id'=>$client_id,'balance'=>$balance,'currency_code'=>$currency_code) ,true),'active'=>true),
        //array('label'=>Yii::t('app','Paid Invoice'),'id'=>'tab_2', 'content'=>$this->renderPartial('partial/_invoice_his', array('model'=>$model,'client_id'=>$client_id,'balance'=>$balance,'currency_code'=>$currency_code),true)),
        //array('label'=>Yii::t('app','Payment History'),'id'=>'tab_3', 'content'=>$this->renderPartial('partial/_sale_payment', array('model'=>$model,'client_id'=>$client_id,'balance'=>$balance,'currency_code'=>$currency_code),true)),
    ),
    //'events'=>array('shown'=>'js:loadContent')
));
