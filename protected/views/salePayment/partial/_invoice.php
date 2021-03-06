<?php $this->widget('EExcelView',array(
        'id'=>'invoice-grid',
        'fixedHeader' => true,
        //'responsiveTable' => true,
        'type'=>'striped bordered hover',
        'template'=>"{summary}\n{items}\n{exportbuttons}\n{pager}",
        'dataProvider'=>$model->invoice($client_id,'>'),
        'summaryText' =>'<p class="text-info"> Outstanding Invoice </p>',
        'htmlOptions'=>array('class'=>'table-responsive panel'),
        'columns'=>array(
                array('name'=>'id',
                      'header'=>Yii::t('app','Invoice ID'),
                      'type'=>'raw',
                      'value'=>'$data["sale_id"]',  
                ),
                array('name'=>'client_name',
                      'header'=>Yii::t('app','Customer Name'), 
                      'value'=>'$data["client_name"]',
                ),
                array('name'=>'currency_name',
                    'header'=>Yii::t('app','Account Type'),
                    'value'=>'$data["currency_name"]',
                ),
                array('name'=>'sale_time',
                      'header'=>Yii::t('app','Sale Time'),
                      'value'=>'$data["sale_time"]',
                      //'value'=>'CHtml::link($data["sale_time"], Yii::app()->createUrl("saleitem/admin",array("id"=>$data["id"])))',
                      //'type'=>'raw',
                ),
                array('name'=>'sub_total',
                      'header'=>Yii::t('app','Sub Total'),   
                      'headerHtmlOptions'=>array('style' => 'text-align: right;'),
                      'value' =>'number_format($data["sub_total"],Common::getDecimalPlace(), ".", ",")',
                      'htmlOptions'=>array('style' => 'text-align: right;'),
                ),
                array('name'=>'discount_amount',
                      'header'=>Yii::t('app','Discount'),   
                      'headerHtmlOptions'=>array('style' => 'text-align: right;'),
                      'value' =>'number_format($data["discount_amount"],Common::getDecimalPlace(), ".", ",")',
                      'htmlOptions'=>array('style' => 'text-align: right;'),
                ),
                array('name'=>'paid',
                      'header'=>Yii::t('app','Paid'),   
                      'headerHtmlOptions'=>array('style' => 'text-align: right;'),
                      'value' =>'number_format($data["paid"],Common::getDecimalPlace(), ".", ",")',
                      'htmlOptions'=>array('style' => 'text-align: right;'),
                ),
                array('name'=>'balance',
                      'header'=>Yii::t('app','Balance'),   
                      'headerHtmlOptions'=>array('style' => 'text-align: right;'),
                      'value' =>'$data["currency_symbol"] . number_format($data["balance"],Common::getDecimalPlace(), ".", ",")',
                      'htmlOptions'=>array('style' => 'text-align: right;'),
                      //'footer'=> number_format($balance,Common::getDecimalPlace(),'.', ','),
                      //'footerHtmlOptions'=>array('style' => 'text-align: right;'),
                ),
                array('class'=>'bootstrap.widgets.TbButtonColumn',
                    'header'=>'Action',
                    'template'=>'<div class="btn-group">{view}{payment}</div>',
                    //'htmlOptions'=>array('class'=>'hidden-phone visible-desktop btn-group'),
                    'buttons' => array(
                        'view' => array(
                            'click' => 'updateDialogOpen',
                            'label'=>'Detail',
                            'url'=>'Yii::app()->createUrl("report/SaleInvoiceItem", array("sale_id"=>$data["sale_id"]))',
                            'options' => array(
                                'data-update-dialog-title' => Yii::t( 'app', 'Invoice Detail' ),
                                'title'=>Yii::t('app','Invoice Detail'),
                                'class'=>'btn btn-xs btn-info',
                                //'id'=>uniqid(),
                                //'on'=>false,
                            ),
                        ),
                        'payment' => array(
                            //'click' => 'updateDialogOpen',
                            'label' => 'Payment',
                            'icon' => 'fa fa-heart',
                            'url' => 'Yii::app()->createUrl("SalePayment/SelectInvoice", array("sale_id"=>$data["sale_id"]))',
                            'options' => array(
                                //'data-update-dialog-title' => Yii::t( 'app', 'Invoice Payment' ),
                                'title'=>Yii::t('app','Invoice Payment'),
                                'class'=>'btn btn-xs btn-success btn-invoice-payment',
                                'id'=>uniqid(),
                                'on'=>false,
                            ),
                        ),
                    ),
                ),
        ),
));