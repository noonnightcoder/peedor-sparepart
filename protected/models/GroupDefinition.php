<?php

/**
 * This is the model class for table "group_definition".
 *
 * The followings are the available columns in table 'group_definition':
 * @property integer $id
 * @property string $alt_qty
 * @property integer $alt_uom_id
 * @property string $base_qty
 * @property integer $base_uom_id
 * @property string $created_at
 * @property string $updated_at
 * @property string $deleted_at
 * @property integer $created_by
 * @property integer $updated_by
 * @property integer $deleted_by
 */
class GroupDefinition extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'group_definition';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('alt_qty, alt_uom_id, base_qty, base_uom_id', 'required'),
			array('alt_uom_id, base_uom_id, created_by, updated_by, deleted_by', 'numerical', 'integerOnly'=>true),
			array('alt_qty, base_qty', 'length', 'max'=>13),
			array('created_at, updated_at, deleted_at', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, alt_qty, alt_uom_id, base_qty, base_uom_id, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by', 'safe', 'on'=>'search'),
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
			'alt_qty' => 'Alt Qty',
			'alt_uom_id' => 'Alt Uom',
			'base_qty' => 'Base Qty',
			'base_uom_id' => 'Base Uom',
			'created_at' => 'Created At',
			'updated_at' => 'Updated At',
			'deleted_at' => 'Deleted At',
			'created_by' => 'Created By',
			'updated_by' => 'Updated By',
			'deleted_by' => 'Deleted By',
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
		$criteria->compare('alt_qty',$this->alt_qty,true);
		$criteria->compare('alt_uom_id',$this->alt_uom_id);
		$criteria->compare('base_qty',$this->base_qty,true);
		$criteria->compare('base_uom_id',$this->base_uom_id);
		$criteria->compare('created_at',$this->created_at,true);
		$criteria->compare('updated_at',$this->updated_at,true);
		$criteria->compare('deleted_at',$this->deleted_at,true);
		$criteria->compare('created_by',$this->created_by);
		$criteria->compare('updated_by',$this->updated_by);
		$criteria->compare('deleted_by',$this->deleted_by);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return GroupDefinition the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
