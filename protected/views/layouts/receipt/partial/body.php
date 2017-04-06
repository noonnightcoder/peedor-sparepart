<table class="table" id="receipt_items">
    <thead>
    <tr>
        <th style='border-top:2px solid #000000; border-bottom:2px solid #000000;'><?php echo Yii::t('app','Name'); ?></th>
        <th class="center" style='border-top:2px solid #000000; border-bottom:2px solid #000000;'><?php echo Yii::t('app','Price'); ?></th>
        <th class="center" style='border-top:2px solid #000000; border-bottom:2px solid #000000;'><?php echo TbHtml::encode(Yii::t('app','Qty')); ?></th>
        <!--
                <th class="<?php //echo Yii::app()->settings->get('sale','discount'); ?>">
                    <?php //echo TbHtml::encode(Yii::t('app','Discount')); ?>
                </th>
                -->
        <th class="center" style='border-top:2px solid #000000; border-bottom:2px solid #000000;'><?php echo TbHtml::encode(Yii::t('app','Total')); ?></th>
    </tr>
    </thead>
    <tbody>
    <?php $i=0; ?>
    <?php foreach($items as $id=>$item): ?>
        <?php
        $i=$i+1;
        $total_item=number_format($item['total'],Common::getDecimalPlace());
        $item_id=$item['item_id'];
        ?>
        <tr>
            <!-- <td class="center"><?php //echo TbHtml::encode($i); ?></td> -->

            <td><?php echo TbHtml::encode($item['name']); ?></td>
            <td class="center"><?php echo TbHtml::encode(number_format($item['price'],Common::getDecimalPlace())); ?></td>
            <td class="center"><?php echo TbHtml::encode($item['quantity']); ?></td>
            <!-- <td class="<?php //echo Yii::app()->settings->get('sale','discount'); ?>"><?php //echo TbHtml::encode($item['discount']); ?></td> -->
            <td class="text-right"><?php echo TbHtml::encode($total_item); ?>
        </tr>
    <?php endforeach; ?> <!--/endforeach-->
    <tr class="gift_receipt_element">
        <td colspan="3" style='text-align:right;border-top:2px solid #000000;'><?= Yii::t('app','Sub Total'); ?></td>
        <td colspan="1" style='text-align:right;border-top:2px solid #000000;'>
            <?= number_format($sub_total,Common::getDecimalPlace(), '.', ','); ?>
        </td>
    </tr>
    <tr class="gift_receipt_element">
        <td colspan="3" class="text-right">Discount</td>
        <td colspan="1" class="text-right">
            <?= number_format($discount_amount,Common::getDecimalPlace(), '.', ','); ?>
        </td>
    </tr>
    <tr class="gift_receipt_element">
        <td colspan="3" class="text-right"><?php echo Yii::t('app','Total'); ?></td>
        <td colspan="1" class="text-right">
            <span style="font-size:15px;">
                <?= number_format($total,Common::getDecimalPlace(), '.', ','); ?>
            </span>
        </td>
    </tr>
    <?php foreach($payments as $payment_id=>$payment): ?>
        <tr>
            <td colspan="3" style='text-align:right'><?php echo Yii::t('app','Paid Amount'); ?></td>
            <td colspan="1" style='text-align:right'>
                    <span style="font-size:15px">
                    <?php echo Yii::app()->settings->get('site', 'currencySymbol') . number_format($payment['payment_amount'],Common::getDecimalPlace(), '.', ','); ?>
                    </span>
            </td>
        </tr>
    <?php endforeach;?>
    <tr>
        <td colspan="3" style='text-align:right'><?= Yii::t('app','Change Due'); ?></td>
        <td colspan="1" style='text-align:right'>
            <span style="font-size:15px;">
                <?= number_format($amount_due,Common::getDecimalPlace(), '.', ','); ?>
            </span>
        </td>
    </tr>
    </tbody>
</table>