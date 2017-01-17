<?php

/**
 * This is the model class for table "account".
 *
 * The followings are the available columns in table 'account':
 * @property integer $id
 * @property integer $currency_code
 * @property integer $client_id
 * @property string $name
 * @property string $current_balance
 * @property string $status
 * @property string $date_created
 * @property string $note
 *
 * The followings are the available model relations:
 * @property Client $client
 * @property Transactions[] $transactions
 */
class Account extends CActiveRecord
{
    /**
     * @return string the associated database table name
     */
    public function tableName()
    {
        return 'account';
    }

    /**
     * @return array validation rules for model attributes.
     */
    public function rules()
    {
        // NOTE: you should only define rules for those attributes that
        // will receive user inputs.
        return array(
            array('client_id,currency_code', 'required'),
            array('client_id, currency_code', 'numerical', 'integerOnly' => true),
            array('name', 'length', 'max' => 100),
            array('current_balance', 'length', 'max' => 15),
            array('status', 'length', 'max' => 1),
            array('date_created, note', 'safe'),
            // The following rule is used by search().
            // @todo Please remove those attributes that should not be searched.
            array(
                'id, client_id,currency_code, name, current_balance, status, date_created, note',
                'safe',
                'on' => 'search'
            ),
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
            'client' => array(self::BELONGS_TO, 'Client', 'client_id'),
            'transactions' => array(self::HAS_MANY, 'Transactions', 'account_id'),
        );
    }

    /**
     * @return array customized attribute labels (name=>label)
     */
    public function attributeLabels()
    {
        return array(
            'id' => 'ID',
            'client_id' => 'Client',
            'name' => 'Name',
            'current_balance' => 'Current Balance',
            'status' => 'Status',
            'date_created' => 'Date Created',
            'note' => 'Note',
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

        $criteria = new CDbCriteria;

        $criteria->compare('id', $this->id);
        $criteria->compare('client_id', $this->client_id);
        $criteria->compare('name', $this->name, true);
        $criteria->compare('current_balance', $this->current_balance, true);
        $criteria->compare('status', $this->status, true);
        $criteria->compare('date_created', $this->date_created, true);
        $criteria->compare('note', $this->note, true);

        return new CActiveDataProvider($this, array(
            'criteria' => $criteria,
        ));
    }

    /**
     * Returns the static model of the specified AR class.
     * Please note that you should have this exact method in all your CActiveRecord descendants!
     * @param string $className active record class name.
     * @return Account the static model class
     */
    public static function model($className = __CLASS__)
    {
        return parent::model($className);
    }

    public static function getAccountInfo($client_id)
    {
        $sql = "SELECT a.`client_id`,a.`currency_code`,a.`name`,a.`current_balance`,c.`currency_id`,c.currency_symbol
                FROM account a , `currency_type` c
                WHERE a.`currency_code` = c.code
                AND a.`client_id`=:client_id
                ORDER BY c.sort_order";

        $result = Yii::app()->db->createCommand($sql)->queryAll(true, array(':client_id' => $client_id));

        return $result;

    }

    public static function getAccountByCurType($client_id, $currency_code)
    {
        $sql = "SELECT a.`client_id`,a.`currency_code`,a.`name`,a.`current_balance`,c.`currency_id`,c.currency_symbol
                FROM account a , `currency_type` c
                WHERE a.`client_id`=:client_id
                AND a.`currency_code` = c.code
                AND a.currency_code =:currency_code
                ORDER BY c.sort_order";

        $result = Yii::app()->db->createCommand($sql)->queryAll(true,
            array(':client_id' => $client_id, ':currency_code' => $currency_code));

        return $result;

    }

    public function updateAccountBal($account, $amount)
    {
        // Update Account balance of the Client
        $account->current_balance = $account->current_balance - $amount;
        $account->save();
    }

    public function saveAccount($client_id, $client_fname, $currency_code)
    {
        $account = new Account;
        $account->client_id = $client_id;
        $account->currency_code = $currency_code;
        $account->name = $client_fname;
        $account->status = Yii::app()->params['_active_status'];
        $account->date_created = date('Y-m-d H:i:s');
        $account->save();
    }

    public function createAccount($client_id, $client_fname)
    {
        $currency_type = CurrencyType::model()->getActiveCurrency();
        foreach ($currency_type as $currency) {
            $this->saveAccount($client_id, $client_fname, $currency->code);
        }
    }

    public function updateAccount($client_id, $client_fname)
    {
        $currency_type = CurrencyType::model()->getActiveCurrency();
        foreach ($currency_type as $currency) {
            $account = Account::model()->find('client_id=:client_id and currency_code=:currency_code',
                array(':client_id' => $client_id, ':currency_code' => $currency->code));
            if ($account) {
                $account->name = $client_fname;
                $account->save();
            } else {
                $this->saveAccount($client_id, $client_fname, $currency->code);
            }

        }
    }

}
