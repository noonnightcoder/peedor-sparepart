<?php

/**
 * This is the model class for table "profit_price_tier".
 *
 * The followings are the available columns in table 'profit_price_tier':
 * @property integer $id
 * @property integer $profit_margin_id
 * @property integer $price_tier_id
 * @property string $profit
 */
class ProfitPriceTier extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'profit_price_tier';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('profit_margin_id, price_tier_id', 'required'),
			array('profit_margin_id, price_tier_id', 'numerical', 'integerOnly'=>true),
			array('profit', 'length', 'max'=>10),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, profit_margin_id, price_tier_id, profit', 'safe', 'on'=>'search'),
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
			'profit_margin_id' => 'Profit Margin',
			'price_tier_id' => 'Price Tier',
			'profit' => 'Profit',
		);
	}

	/**
	 * Retrieves a list of models based on the current search/filter conditions.
	 *
	 * Typical usecase:
	 * - Initialize the model fields with values from filter form.
	 * - Execute this method to get CActiveDataProvider instance which will filter
	 * models according to data in model fields.
	 * - Pass data provider to CGridView, CListView or any similar widget.
	 *
	 * @return CActiveDataProvider the data provider that can return the models
	 * based on the search/filter conditions.
	 */
	public function search()
	{
		// @todo Please modify the following code to remove attributes that should not be searched.

		$criteria=new CDbCriteria;

		$criteria->compare('id',$this->id);
		$criteria->compare('profit_margin_id',$this->profit_margin_id);
		$criteria->compare('price_tier_id',$this->price_tier_id);
		$criteria->compare('profit',$this->profit,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return ProfitPriceTier the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
        
        public function saveProfitPriceTier($profit_margin_id,$price_tiers) 
        {
            if ($price_tiers) {
                foreach ($price_tiers as $i=>$price_tier) {
                    $profit=$_POST['ProfitMarginPrice'][$price_tier["tier_id"]];
                    if ($profit!="") {
                        $price_tier_id=$price_tier["tier_id"];
                        $profit_price_tier = $this->findItemPriceTier($profit_margin_id,$price_tier_id);
                        $profit_price_tier->profit_margin_id=$profit_margin_id;
                        $profit_price_tier->price_tier_id=$price_tier_id;
                        $profit_price_tier->profit=$profit;
                        $profit_price_tier->save();
                    }
                }
            }
        }
        
        protected function findItemPriceTier($profit_margin_id,$price_tier_id)
        {
            $profit_price_tier= ProfitPriceTier::model()->find('profit_margin_id=:profit_margin_id AND price_tier_id=:price_tier_id', array(':profit_margin_id'=>(int) $profit_margin_id,':price_tier_id'=> (int) $price_tier_id));
            if (!$profit_price_tier) {
                $profit_price_tier = new ProfitPriceTier;
            }
            return $profit_price_tier;
        }
}
