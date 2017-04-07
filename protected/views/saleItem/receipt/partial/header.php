<div class="row">
    <div class="col-xs-6">
        <p>
            <?php echo TbHtml::image(Yii::app()->baseUrl . '/images/shop_logo.gif','Company\'s logo',array('width'=>'150')); ?> <br>
             <?= TbHtml::encode('The Best Bookshop'); ?> <br>
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?= TbHtml::encode('For Your Education'); ?><br>
        </p>
    </div>
    <div class="col-xs-6 text-right">
        <p>
            <?php echo TbHtml::b(Yii::app()->getsetSession->getLocationName() . ' Branch'); ?> <br>
            <?php echo TbHtml::b(Yii::app()->getsetSession->getLocationNameKH()); ?> <br>
            <?php echo TbHtml::encode('Tel: ' . Yii::app()->getsetSession->getLocationPhone()); ?> <br>
            <?php //echo TbHtml::encode(Yii::app()->getsetSession->getLocationPhone1()); ?>  <br>
            <?php //echo TbHtml::encode(Yii::app()->getsetSession->getLocationAddress()); ?>  <br>
            <?php //echo TbHtml::encode(Yii::app()->getsetSession->getLocationAddress1()); ?> <br>
            <?php //echo TbHtml::encode(Yii::app()->getsetSession->getLocationAddress2()); ?> <br>
        </p>
    </div>
</div>

<div class="row">
    <div class="col-xs-6">
        <p>
            <?php echo Yii::t('app','Cashier') . " : ". TbHtml::encode(ucwords($employee_name)); ?> <br>
            <?php echo Yii::t('app','Customer') . " : ". TbHtml::b(TbHtml::encode(ucwords($client_name))); ?>  <br>
            <?php /*echo TbHtml::encode(Yii::t('app','Wifi Pass')  . ' ' . Yii::app()->getsetSession->getLocationWifi()); */?><!-- <br>-->
        </p>
    </div>
    <div class="col-xs-6 text-right">
        <p>
            <?php echo TbHtml::encode(Yii::t('app','Invoice ID') . " : "  . Yii::app()->getsetSession->getLocationCode() . ' - ' . $sale_id); ?> <br>
            <?php echo TbHtml::encode(Yii::t('app','Date') . " : ". $sale_time); ?> <br>
            <?php //echo TbHtml::encode(Yii::t('app','Time') . " : ". $transaction_time); ?> <br>
        </p>
    </div>
</div>