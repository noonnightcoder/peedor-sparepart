<div class="row">
    <div class="sidebar-nav" id="payment_cart">
        <?php if ($count_item <> 0) { ?>
            <?php
            $form = $this->beginWidget('bootstrap.widgets.TbActiveForm', array(
                'id' => 'finish_sale_form',
                'action' => Yii::app()->createUrl('saleItem/completeSale/',array('action_status' => Yii::app()->params['order_status_complete'])),
                'enableAjaxValidation' => false,
                'layout' => TbHtml::FORM_LAYOUT_INLINE,
            ));
            ?>

            <table class="table table-bordered table-condensed">
                <tbody>
                <tr>
                    <td><?php echo Yii::t('app', 'Item in Cart'); ?> :</td>
                    <td><?= $count_item; ?></td>
                </tr>

                <?php if (Common::getSaleType()=='W') {

                    $this->renderPartial('partial/_right_panel_total_wsale');

                } else {
                    $this->renderPartial('partial/_right_panel_total_retail', array(
                        'count_payment' => $count_payment,
                        'model' => $model,
                    ));
                }
                ?>

                <?php /*if (Common::getSaleType()=='R') {
                    $this->renderPartial('partial/_right_panel_payment_retail', array(
                        'count_payment' => $count_payment,
                        'model' => $model,
                    ));
                }
                */?>
                </tbody>
            </table>

            <?php $this->endWidget(); ?>
        <?php } ?>
    </div>
</div>