<?php
Class Cart
{
    public static function addCart($items,$item_id,$quantity,$discount,$price_tier,$price,$cost_price,$unit_price,$description,$expire_date) {

        $models = Item::model()->getItemPriceTierWS($item_id, $price_tier);

        if (empty($models)) {
            $models = Item::model()->getItemPriceTierItemNumWS($item_id, $price_tier);
            foreach ($models as $model) {
                $item_id=$model["id"];
            }
        }

        if (!$models) {
            return false;
        }

        foreach ($models as $model) {

            $item_data = array((int)$item_id =>
                array(
                    'item_id' => $model["id"],
                    'currency_code' => $model["currency_code"],
                    'currency_id' => $model["currency_id"],
                    'currency_symbol' => $model["currency_symbol"],
                    'name' => $model["name"],
                    'item_number' => $model["item_number"],
                    'quantity' => $quantity,
                    'cost_price' => $cost_price != null ? round($cost_price, Common::getDecimalPlace()) : round($model->cost_price, Common::getDecimalPlace()),
                    'unit_price' => $unit_price != null ? round($unit_price, Common::getDecimalPlace()) : round($model->unit_price, Common::getDecimalPlace()),
                    'price' => $price!= null ? round($price, Common::getDecimalPlace()) : round($model["price"], Common::getDecimalPlace()),
                    'to_val' => 1,
                    'discount' => $discount,
                    'expire_date' => $expire_date,
                    'description' => $description!= null ? $description : $model["description"],
                )
            );
        }

        if (isset($items[$item_id])) {
            $items[$item_id]['quantity']+=$quantity;
        } else {
            $items += $item_data;
        }

       return $items;
    }

    public static function editCart($items,$item_id, $quantity = 1, $discount, $price, $description,$expire_date) {
        if (isset($items[$item_id])) {
            $items[$item_id]['quantity'] = $quantity !=null ? $quantity : $items[$item_id]['quantity'];
            $items[$item_id]['discount'] = $discount !=null ? $discount : $items[$item_id]['discount'];
            $items[$item_id]['price'] = $price !=null ? round($price, Common::getDecimalPlace()) : $items[$item_id]['price'];
            $items[$item_id]['expire_date'] = $expire_date;
            $items[$item_id]['description'] = $description;
        }

        return $items;
    }

    
}