<div class="grid-view" id="grid_cart">

    <?php $this->renderPartial('//layouts/alert/_flash'); ?>

    <table class="table table-hover table-condensed">
        <thead>
        <tr>
            <th><?php echo Yii::t('app', 'Item Name'); ?></th>
            <th><?php echo Yii::t('app', 'Price'); ?></th>
            <th><?php echo Yii::t('app', 'Price KH'); ?></th>
            <th><?php echo Yii::t('app', 'Quantity'); ?></th>
            <th class="<?php echo Yii::app()->settings->get('sale', 'discount'); ?>"><?php echo Yii::t('app',
                    'Discount'); ?></th>
            <th><?php echo Yii::t('app', 'Total'); ?></th>
            <th><?php echo Yii::t('app', 'Total KH'); ?></th>
            <th></th>
        </tr>
        </thead>
        <tbody id="cart_contents">
        <?php foreach (array_reverse($items, true) as $id => $item): ?>
            <?php
            //$$total_item = Common::calTotalAfterDiscount($item['discount'],$item['price_kh'],$item['quantity']);
            $item_id = $item['item_id'];
            $cur_item_info = Item::model()->findbyPk($item_id);
            $qty_in_stock = $cur_item_info->quantity;
            ?>
            <tr>
                <td>
                    <?php echo $item['name']; ?><br/>
                    <span class="text-info"><?php echo $qty_in_stock . ' ' . Yii::t('app', 'in stock') ?> <?= $item['price_verify']; ?> </span>
                </td>
                <td>
                    <?php $form = $this->beginWidget('bootstrap.widgets.TbActiveForm', array(
                        'method' => 'post',
                        'action' => Yii::app()->createUrl('saleItem/editItem/', array('item_id' => $item['item_id'])),
                        'htmlOptions' => array('class' => 'line_item_form'),
                    ));
                    ?>
                    <span class="input-icon">
                        <?php echo $form->textField($model, "price", array(
                            'value' => $item['price'],
                            'class' => 'input-small input-grid',
                            'id' => "price_$item_id",
                            'placeholder' => 'Price',
                            'maxlength' => 10
                        )); ?>
                        <i class="ace-icon blue"><?= $item['currency_symbol']; ?> </i>
                    </span>
                    <?php $this->endWidget(); ?>
                </td>
                <td>
                    <?= $item['price_kh']; ?>
                </td>
                <td>
                    <?php $form = $this->beginWidget('bootstrap.widgets.TbActiveForm', array(
                        'method' => 'post',
                        'action' => Yii::app()->createUrl('saleItem/editItem/', array('item_id' => $item['item_id'])),
                        'htmlOptions' => array('class' => 'line_item_form'),
                    ));
                    ?>
                        <?php echo $form->textField($model, "quantity", array(
                            'value' => $item['quantity'],
                            'class' => 'input-small input-grid',
                            'id' => "quantity_$item_id",
                            'placeholder' => 'Quantity',
                            'maxlength' => 10
                        )); ?>
                    <?php $this->endWidget(); ?>
                </td>
                <td class="<?php echo Yii::app()->settings->get('sale', 'discount'); ?>">
                    <?php $form = $this->beginWidget('bootstrap.widgets.TbActiveForm', array(
                        'method' => 'post',
                        'action' => Yii::app()->createUrl('saleItem/editItem/', array('item_id' => $item['item_id'])),
                        'htmlOptions' => array('class' => 'line_item_form'),
                    ));
                    ?>
                    <?php echo $form->textField($model, "discount", array(
                            'value' => $item['discount'],
                            'class' => 'input-small input-grid',
                            'id' =>
                                "discount_$item_id",
                            'placeholder' => 'Discount',
                            'data-id' => "$item_id",
                            'maxlength' => 9,
                            //'disabled'=>$disable_discount,
                        )
                    );
                    ?>
                    <?php $this->endWidget(); ?>
                </td>
                <td><?= $item['currency_symbol'] . $item['total'] ?>
                <td><?= $item['total_kh'] ?>
                <td><?php
                    echo TbHtml::linkButton('', array(
                        'color' => TbHtml::BUTTON_COLOR_DANGER,
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
                <?php $form = $this->beginWidget('bootstrap.widgets.TbActiveForm', array(
                    'method' => 'post',
                    'action' => Yii::app()->createUrl('saleItem/setTotalDiscount/'),
                    'id' => 'total_discount_form'
                ));
                ?>
                <?php echo $form->textField($model, 'total_discount', array(
                        'id' => 'total_discount_id',
                        'class' => 'col-xs-12 input-totaldiscount',
                        'placeholder' => 'Total Discount',
                        'maxlength' => 25,
                        'append' => '%',
                        //'disabled' => $disable_discount
                    )
                ); ?>
                <?php $this->endWidget(); ?>
            </div>
        </div>
    <?php } ?>

</div> <!-- #section:grid.cart.layout -->