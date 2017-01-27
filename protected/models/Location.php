<?php

/**
 * This is the model class for table "location".
 *
 * The followings are the available columns in table 'location':
 * @property integer $id
 * @property integer $parent_id
 * @property string $name
 * @property string $name_kh
 * @property string $loc_code
 * @property string $address
 * @property string $address1
 * @property string $address2
 * @property string $phone
 * @property string $phone1
 * @property string $wifi_password
 * @property string $email
 * @property string $printer1
 * @property string $printer2
 * @property string $printer3
 * @property string $printer4
 * @property string $vat
 * @property string $created_at
 * @property string $updated_at
 * @property string $deleted_at
 * @property integer $created_by
 * @property integer $updated_by
 * @property integer $deleted_by
 * @property string $status
 */
class Location extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'location';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('name, created_at', 'required'),
			array('parent_id, created_by, updated_by, deleted_by', 'numerical', 'integerOnly'=>true),
			array('name, name_kh, address, address1, address2', 'length', 'max'=>200),
			array('loc_code, vat', 'length', 'max'=>10),
			array('phone, phone1', 'length', 'max'=>20),
			array('wifi_password, email', 'length', 'max'=>30),
			array('printer1, printer2, printer3, printer4', 'length', 'max'=>100),
			array('status', 'length', 'max'=>1),
            array('updated_at','default',
                'value'=>new CDbExpression('NOW()'),
                'setOnEmpty'=>false,'on'=>'update'),
            array('created_at,updated_at','default',
                'value'=>new CDbExpression('NOW()'),
                'setOnEmpty'=>false,'on'=>'insert'),
			array('updated_at, deleted_at', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, parent_id, name, name_kh, loc_code, address, address1, address2, phone, phone1, wifi_password, email, printer1, printer2, printer3, printer4, vat, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by, status', 'safe', 'on'=>'search'),
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
			'parent_id' => 'Parent',
			'name' => 'Name',
			'name_kh' => 'Name Kh',
			'loc_code' => 'Loc Code',
			'address' => 'Address',
			'address1' => 'Address1',
			'address2' => 'Address2',
			'phone' => 'Phone',
			'phone1' => 'Phone1',
			'wifi_password' => 'Wifi Password',
			'email' => 'Email',
			'printer1' => 'Printer1',
			'printer2' => 'Printer2',
			'printer3' => 'Printer3',
			'printer4' => 'Printer4',
			'vat' => 'Vat',
			'created_at' => 'Created At',
			'updated_at' => 'Updated At',
			'deleted_at' => 'Deleted At',
			'created_by' => 'Created By',
			'updated_by' => 'Updated By',
			'deleted_by' => 'Deleted By',
			'status' => 'Status',
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
		$criteria->compare('parent_id',$this->parent_id);
		$criteria->compare('name',$this->name,true);
		$criteria->compare('name_kh',$this->name_kh,true);
		$criteria->compare('loc_code',$this->loc_code,true);
		$criteria->compare('address',$this->address,true);
		$criteria->compare('address1',$this->address1,true);
		$criteria->compare('address2',$this->address2,true);
		$criteria->compare('phone',$this->phone,true);
		$criteria->compare('phone1',$this->phone1,true);
		$criteria->compare('wifi_password',$this->wifi_password,true);
		$criteria->compare('email',$this->email,true);
		$criteria->compare('printer1',$this->printer1,true);
		$criteria->compare('printer2',$this->printer2,true);
		$criteria->compare('printer3',$this->printer3,true);
		$criteria->compare('printer4',$this->printer4,true);
		$criteria->compare('vat',$this->vat,true);
		$criteria->compare('created_at',$this->created_at,true);
		$criteria->compare('updated_at',$this->updated_at,true);
		$criteria->compare('deleted_at',$this->deleted_at,true);
		$criteria->compare('created_by',$this->created_by);
		$criteria->compare('updated_by',$this->updated_by);
		$criteria->compare('deleted_by',$this->deleted_by);
		$criteria->compare('status',$this->status,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return Location the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}

    protected function getLocationInfo()
    {
        return $this->name; //. ' ( ' . $this->phone . ' )';
    }

    public function getLocation()
    {
        $model = Location::model()->findAll();
        $list = CHtml::listData($model, 'id', 'LocationInfo');
        return $list;
    }
}
