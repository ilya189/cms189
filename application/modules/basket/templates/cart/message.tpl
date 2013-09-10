<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional //EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
</head>
<body style="font-family: 'Trebuchet MS', Tahoma, sans-serif; font-size: 14px; margin:0; padding:0;">


<table border="0" cellspacing="0" cellpadding="50" style="border-collapse: collapse; font-family: 'Trebuchet MS', Tahoma, sans-serif; font-size: 14px; margin: 0; padding: 0;width:100%;">
    <tr>
        <td align="center" valign="top" style="text-align: center">
            <table border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse;  margin-left: auto; margin-right: auto; text-align: left;" width="600" bgcolor="#ffffff">
                <tr>
                    <td>
                        <div style="margin:0 0 15px 0;">
                            <table cellpadding="10" cellspacing="0" style="border-collapse:collapse; border: 1px solid #208E24; width:100%;">
                                <tr>
                                    <th style="background: #7aba7b;text-shadow: 1px 1px 0 #999999;border: 1px solid #208E24;">Фото товара</th>
                                    <th style="background: #7aba7b;text-shadow: 1px 1px 0 #999999;border: 1px solid #208E24;">Наименование, описание</th>
                                    <th style="background: #7aba7b;text-shadow: 1px 1px 0 #999999;width:100px;border: 1px solid #208E24;">Цена</th>
                                    <th style="background: #7aba7b;text-shadow: 1px 1px 0 #999999;border: 1px solid #208E24;">Кол-во</th>
                                </tr>
                                {foreach $cart->contents() as $item}
                                <tr>
                                    <td style="border: 1px solid #208E24;">
                                        <img alt="" src="{$BASE_URL}{image_resize($item['img'],"x100")}" />
                                    </td>
                                    <td style="border: 1px solid #208E24;">
                                        <div style="text-align: left;">
                                            {$item['name']}{if $item['options']['price'] == 1} (c подступенниками){/if}
                                        </div>
                                    </td>
                                    <td style="border: 1px solid #208E24;">{number_format($item['price'], 2, '.', ' ')}</td>
                                    <td style="border: 1px solid #208E24;">
                                        {$item['qty']}
                                    </td>
                                </tr>
                                {/foreach}
                            </table>
                        </div>
                        <div style="text-align:right; margin: 10px 0;">
                            Сумма заказа:
                            <span style="font-weight: bold;">{number_format($cart->total(), 2, '.', ' ')}</span>
                        </div>

                        <p><b>ФИО:</b> {$fio}</p>
                        <p><b>Организация:</b> {$org}</p>
                        <p><b>Телефон:</b> {$phone}</p>
                        <p><b>E-mail:</b> {$email}</p>
                        <p><b>Адрес доставки:</b> {$toadres}</p>
                        <p><b>Комментарии к заказу:</b>
                        <blockquote>
                            {$comment}
                        </blockquote>
                        </p>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

</body>
</html>