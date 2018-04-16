<?php

/**
 * This is the model class for table "price_tier".
 *
 * The followings are the available columns in table 'price_tier':
 * @property integer $id
 * @property string $tier_name
 * @property string $created_at
 * @property string $updated_at
 * @property string $status
 */
class PriceTier extends CActiveRecord
{
    public $search;
    public $archived;

	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'price_tier';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('tier_name', 'required'),
                        array('tier_name', 'unique'),
			array('status', 'length', 'max'=>1),
			array('tier_name', 'length', 'max'=>30),
			array('description', 'length', 'max'=>1000),
			array('sort_order', 'numerical'),
            array('created_at', 'default', 'value' => date('Y-m-d H:i:s'), 'setOnEmpty' => true, 'on' => 'insert'),
            array('updated_at', 'default', 'value' => date('Y-m-d H:i:s'), 'setOnEmpty' => false, 'on' => 'update'),
			array('created_at,updated_at', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, tier_name,status, search', 'safe', 'on'=>'search'),
		);
	}

	/**
	 * @return array relational rules.
	 */
	public function relations()
	{
		// NOTE: you may need to adjust the relation name and the related
		// class name for the relations automatically generated below.
		return array(
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'tier_name' => Yii::t('app','Tier Name'),
			'created_at' => 'Created At',
			'status' => Yii::t('app','Status'),
		);
	}

	public function search()
	{
		// @todo Please modify the following code to remove attributes that should not be searched.

		$criteria=new CDbCriteria;

		//$criteria->compare('id',$this->id);
		//$criteria->compare('tier_name',$this->tier_name,true);

        if  ( Yii::app()->user->getState('archivedPriceTier', Yii::app()->params['defaultArchived'] ) == 'true' ) {
            $criteria->condition = 't.tier_name LIKE :name';
            $criteria->params = array(
                ':name' => '%' . $this->search . '%',
            );
        } else {
            $criteria->condition = 't.status=:active_status AND (t.tier_name LIKE :name)';
            $criteria->params = array(
                ':active_status' => Yii::app()->params['active_status'],
                ':name' => '%' . $this->search . '%',
            );
        }


		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
            'pagination' => array(
                'pageSize' => Yii::app()->user->getState('pageSizePriceTier',Yii::app()->settings->get('item', 'itemNumberPerPage')),
            ),
		));
	}

	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}

    public function deletePriceTeir($id)
    {
        PriceTier::model()->updateByPk((int)$id, array('status' => Yii::app()->params['inactive_status']));
    }

    public function undodeletePriceTeir($id)
    {
        PriceTier::model()->updateByPk((int)$id, array('status' => Yii::app()->params['active_status']));
    }

    protected function getPriceTierInfo()
    {
        return $this->tier_name;
    }

    public function getPriceTier()
    {
        $model = PriceTier::model()->findAll(array(
            'order' => 'id',
            'condition' => 'status=:active_status',
            'params' => array(':active_status' => Yii::app()->params['active_status'])
        ));
        $list = CHtml::listData($model, 'id', 'PriceTierInfo');

        return $list;
    }

    public function getListPriceTier()
    {
        $sql = "SELECT id tier_id,tier_name,null price FROM `price_tier` WHERE status=:active_status ORDER BY id";
        $result = Yii::app()->db->createCommand($sql)->queryAll(true,
            array(':active_status' => Yii::app()->params['active_status']));

        return $result;
    }

    public function getListProfitPriceTier($profit_margin_id, $cost_price)
    {
        $sql = "SELECT pt.id tier_id,tier_name,:cost_price + (:cost_price * ppt.`profit`)/100 price
                  FROM `price_tier` pt LEFT JOIN profit_price_tier ppt ON ppt.`price_tier_id`=pt.id
                                        and ppt.profit_margin_id=:profit_margin_id
                  WHERE STATUS=:active_status
                  ORDER BY pt.id";
        $result = Yii::app()->db->createCommand($sql)->queryAll(true, array(
            ':cost_price' => $cost_price,
            ':profit_margin_id' => $profit_margin_id,
            ':active_status' => Yii::app()->params['active_status']
        ));

        return $result;
    }

    public function getListPriceTierUpdate($item_id)
    {
        $sql = "SELECT pt.id tier_id,pt.tier_name,price
                  FROM price_tier pt LEFT JOIN item_price_tier ipt ON ipt.`price_tier_id`=pt.id 
                            AND ipt.`item_id`=:item_id
                  WHERE pt.status=:status
                  ORDER BY pt.id";

        $result = Yii::app()->db->createCommand($sql)->queryAll(true,
            array(':item_id' => (int)$item_id, ':status' => Yii::app()->params['active_status']));

        return $result;
    }

    public function getProfitPriceTierUpdate($profit_margin_id)
    {
        $sql = "SELECT pt.id tier_id,pt.tier_name,ppt.profit price
                  FROM price_tier pt LEFT JOIN profit_price_tier ppt ON ppt.`price_tier_id`=pt.id 
                            AND ppt.`profit_margin_id`=:profit_margin_id
                  WHERE pt.status=:status          
                  ORDER BY pt.id";

        $result = Yii::app()->db->createCommand($sql)->queryAll(true,
            array(':profit_margin_id' => $profit_margin_id, ':status' => Yii::app()->params['active_status']));

        return $result;
    }

    public function checkExists()
    {
        return PriceTier::model()->count('status=:active_status', array(':active_status' => Yii::app()->params['active_status']));
    }
        
       
}
