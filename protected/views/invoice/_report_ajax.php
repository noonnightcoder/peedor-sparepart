
<?php $this->widget('bootstrap.widgets.TbGridView',array(
	'id'=>'invoice-grid',
	'dataProvider'=>$model->dailyInvoice(),
	'columns'=>array(
                'date_issued',
                'invoice_number',
		array('name'=>'client_search',
                      'value'=>'$data->client->fullname',
                    ),
                array('name'=>'debter',
                      'value'=>array($this,"gridDebterColumn"),
                    ),    
                array('name'=>'amount',
                      'header'=>'Amount',
                      'value' =>'Yii::app()->numberFormatter->formatDecimal($data->amount)',
                      //'footer'=>Yii::app()->getNumberFormatter()->formatCurrency($model->dailyInvoiceTotalAmount(),'KHR'),  
                      'footer'=>Yii::app()->getNumberFormatter()->formatDecimal($model->dailyInvoiceTotalAmount()), 
                     ),   
                array('name'=>'give_away',
                      //'value'=>array($this,"gridGiveAwayColumn
                      'value' =>'Yii::app()->numberFormatter->formatDecimal($data->give_away)',
                      //'footer'=>Yii::app()->numberFormatter->formatCurrency($model->getTotalGiveAway($model->searchReport()->getKeys())),
                     //'footer'=>Yii::app()->getNumberFormatter()->formatCurrency($model->dailyInvoiceTotalGiveAway(),'KHR'),
                    'footer'=>Yii::app()->getNumberFormatter()->formatDecimal($model->dailyInvoiceTotalGiveAway()),
                ),      
                array('name'=>'amount_paid',
                     //'value'=>array($this,"gridPaymentColumn"),
                     'value' =>'Yii::app()->numberFormatter->formatDecimal($data->amount_paid)',
                     //'footer'=>Yii::app()->numberFormatter->formatCurrency($model->getTotalAmountPaid($model->searchReport()->getKeys())),
                    //'footer'=>Yii::app()->getNumberFormatter()->formatCurrency($model->dailyInvoiceTotalAmountPaid(),'KHR'),  
                    'footer'=>Yii::app()->getNumberFormatter()->formatDecimal($model->dailyInvoiceTotalAmountPaid()),
                ),           
                array('name'=>'outstanding',
                      //'value'=>array($this,"gridOutstandingColumn"),
                      'value' =>'Yii::app()->numberFormatter->formatDecimal($data->outstanding)',
                      'footer'=>Yii::app()->getNumberFormatter()->formatDecimal($model->dailyInvoiceTotalOutstanding()),
                     //'footer'=>Yii::app()->getNumberFormatter()->formatCurrency($model->dailyInvoiceTotalOutstanding(),'KHR'),  
                      //'footer'=>Yii::app()->numberFormatter->formatCurrency($model->getTotalOutstanding($model->searchReport()->getKeys())),
                ),
	),
)); ?>

