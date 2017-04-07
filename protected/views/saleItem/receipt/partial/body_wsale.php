<table class="table" id="receipt_items">
    <thead>
    <tr>
        <th><?php echo Yii::t('app','Name'); ?></th>
        <?php foreach ($currency_type as $id => $currency): ?>
            <th class="center"><?php echo Yii::t('app','Price in') . ' ' . $currency->currency_id; ?></th>
        <?php endforeach; ?>
        <th class="center" ><?php echo TbHtml::encode(Yii::t('app','Qty')); ?></th>
        <th class="<?php echo 'center' . ' ' . Yii::app()->settings->get('sale','discount'); ?>">
            <?php echo TbHtml::encode(Yii::t('app','Discount')); ?>
        </th>
        <th class="text-right"><?php echo TbHtml::encode(Yii::t('app','Total')); ?></th>
    </tr>
    </thead>
    <tbody>
    <?php foreach(array_reverse($items,true) as $id=>$item): ?>
        <tr>
            <td><?php echo TbHtml::encode($item['name']); ?></td>
            <?php foreach ($currency_type as $currency): ?>
                <?php if ($item["currency_code"] == $currency->code ) { ?>
                    <td class="center">
                        <?php echo TbHtml::encode(number_format($item['price'],Common::getDecimalPlace())); ?>
                    </td>
                <?php } else { ?>
                    <td class="center">
                        <?php echo '0'; //echo TbHtml::encode(number_format($item['price'],Common::getDecimalPlace())); ?>
                    </td>
                <?php } ?>
            <?php endforeach; ?>
            <td class="center"><?= TbHtml::encode($item['quantity']); ?></td>
            <td class="<?= 'center' . ' ' . Yii::app()->settings->get('sale','discount'); ?>">
                <?php echo TbHtml::encode($item['discount']); ?>
            </td>
            <td class="text-right">
                <?php echo TbHtml::encode($item["currency_symbol"] . $item['total']); ?>
            </td>
        </tr>
    <?php endforeach; ?> <!--/endforeach-->

    <?php foreach ($sale_infos as $i => $sale_info): ?>
        <tr class="gift_receipt_element">
            <td colspan="<?= $col_span; ?>" style='text-align:right;border-top:2px solid #000000;'>
                <?php echo Yii::t('app','Summary of ') . ' ' . $sale_info["currency_id"]; ?></td>
            <td colspan="<?= $col_span; ?>" style='text-align:right;border-top:2px solid #000000;'>
                <?= number_format($sale_info["sub_total"],Common::getDecimalPlace(), '.', ','); ?>
                <?= " - " ?>
                <?= number_format($sale_info["discount_amount"],Common::getDecimalPlace(), '.', ','); ?>
                <?= " = " ?>
                <?= $sale_info["currency_symbol"]  . number_format($sale_info["total"],Common::getDecimalPlace(), '.', ','); ?>
            </td>
        </tr>
    <?php endforeach; ?>

    </tbody>
</table>