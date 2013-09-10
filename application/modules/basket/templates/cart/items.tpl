<table>
    <tr>
        <th>Фото товара</th>
        <th>Наименование, описание</th>
        <th width="100px">Цена</th>
        <th>Кол-во</th>
        <th width="30px;"><img title="Убрать все товары" width="14" height="17" style="cursor:pointer;" alt="" src="{$THEME}images/delete.png" onclick="cart_destroy();"></th>
    </tr>
    {foreach $cart->contents() as $item}
        <tr>
            <td>
                <a href="{$item['url']}">
                    <img alt="" src="{$BASE_URL}{image_resize($item['img'],"x100")}" />
                    <input type="hidden" name="roid[]" value="{$item['rowid']}" />
                </a>
            </td>
            <td>
                <div style="text-align: left;">
                    {$item['name']}{if $item['options']['price'] == 1} (c подступенниками){/if}
                </div>
            </td>
            <td>{number_format($item['price'], 2, '.', ' ')}</td>
            <td>
                <div class="ajax-div">
                    <img class="ajax-img" src="{$THEME}images/ajax-loader.gif">
                    <input class="count-item" type="text" value="{$item['qty']}" onchange="cart_item_update(this,'{$item['rowid']}');">
                </div>
            </td>
            <td>
                <div class="ajax-div">
                    <img class="ajax-img" src="{$THEME}images/ajax-loader.gif">
                    <img title="Убрать товар" width="14" height="17" style="cursor:pointer;" alt="" src="{$THEME}images/delete.png" onclick="cart_item_delete(this,'{$item['rowid']}');">
                </div>
            </td>
        </tr>
    {/foreach}
</table>
<div style="text-align:right; margin: 10px 0;">
    Сумма заказа:
    <span id="total-sum">{number_format($cart->total(), 2, '.', ' ')}</span>
</div>