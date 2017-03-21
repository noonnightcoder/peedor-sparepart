<?php foreach (SaleOrder::model()->getAllTotal() as $record): ?>
    <tr>
        <td><?= Yii::t('app','Total') . ' ' .  $record['currency_symbol'] ?> </td>
        <td><?= $record['currency_symbol'] . ' ' . number_format($record['total'],0,'.',',') ?></td>
    </tr>
<?php endforeach; ?>

<td colspan="3" style='text-align:right'>
    <?php
    echo TbHtml::linkButton(Yii::t('app', 'Complete Sale'), array(
        'color' => TbHtml::BUTTON_COLOR_SUCCESS,
        'icon' => 'glyphicon glyphicon-off white',
        //'url' => Yii::app()->createUrl('SaleItem/CompleteSale/'),
        'class' => 'complete-sale',
        'id' => 'finish_sale_button',
        'title' => Yii::t('app', 'Complete Sale'),
    ));
    ?>
</td>



