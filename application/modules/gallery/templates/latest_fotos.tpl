<div id="gallery_latest_images">
    {foreach $images as $image}
        {die()}
        <a href="{site_url($image.url)}"><img height="200" src="{$image.thumb_path}" title="{$image.description}" /></a>
    {/foreach}
</div>
