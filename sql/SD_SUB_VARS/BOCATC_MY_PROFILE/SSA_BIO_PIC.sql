select nvl(cencustbio.show_thumbnail ( p_cust_id => :p_cust_id ),'<div class="profileInfo-img"><img src="/img/profile_photo.jpg"></i></div>') from dual