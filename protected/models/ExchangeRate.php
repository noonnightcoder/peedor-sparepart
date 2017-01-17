<?php

/**
 * This is the model class for table "exchange_rate".
 *
 * The followings are the available columns in table 'exchange_rate':
 * @property integer $id
 * @property integer $base_currency_code
 * @property integer $to_currency_code
 * @property double $base_val
 * @property double $to_val
 */
class ExchangeRate extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'exchange_rate';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('base_currency_code, to_currency_code, to_val', 'required'),
			array('base_currency_code, to_currency_code', 'numerical', 'integerOnly'=>true),
			array('base_val, to_val', 'numerical'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, base_currency_code, to_currency_code, base_val, to_val', 'safe', 'on'=>'search'),
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
			'base_currency' => array(self::BELONGS_TO, 'CurrencyType', 'base_currency_code'),
			'to_currency' => array(self::BELONGS_TO, 'CurrencyType', 'to_currency_code'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'base_currency_code' => 'Base Currency Code',
			'to_currency_code' => 'To Currency Code',
			'base_val' => 'Base Val',
			'to_val' => 'To Val',
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
		$criteria->compare('base_currency_code',$this->base_currency_code);
		$criteria->compare('to_currency_code',$this->to_currency_code);
		$criteria->compare('base_val',$this->base_val);
		$criteria->compare('to_val',$this->to_val);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return ExchangeRate the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
