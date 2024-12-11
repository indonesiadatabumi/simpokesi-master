


/* serarch npwpd, kode jenis pajak:
-	1:Pajak hotel
-	2: Pajak Resto
-	3: Pajak hiburan
-	4: Pajak reklame
-	6: Pajak PJ
-	7: Pajak Parkir
-	8: Pajak Air tanah 
*/

function mask_npwpd(name,jenis){
	let npwpd=$('#search_npwpd');
    npwpd.mask('P.9.99.9999999.99.99',{
    	placeholder: "P._.__._______.__.__",
    	'translation': {
       // 	S: {pattern: /[Pp]/},
        	9:{pattern: /[0-9]/}
        },
        onKeyPress: function (value, event) {
         event.currentTarget.value = value.toUpperCase();
        }
    });
    
	npwpd.keyup(function() {
     //   console.log('up');
        let th=$(this);
        let no_npwpd=th.val();
        
        if (no_npwpd.length>=14){
           // console.log('start',th.val());
            th.attr('disabled','disabled');
            let link = `http://sipdah.bekasikota.go.id/api/simpokesi/data_wp`;
            let spin=$('.spinner-npwpd');
            spin.attr('style','');
            
            $.ajax({
                url: link,
                type: 'POST',
                data: JSON.stringify({
                    'npwpd' : no_npwpd,
					'jenis_pajak': jenis+''
                }),
                contentType: "application/json; charset=utf-8",
                traditional: true,
                dataType: 'json',
                success: function(res) {
					if(res.statusError=='00'){
                    	respValue(name,res.data);
                    }else{
                        respValue(name);
                        
                        if(res.statusError=='99'){
    						$('[name="'+name+'[status_aktif_id]"]').val('1').change();
    					}
                        
                        th.parent().append('<div class="invalid-feedback err_npwpd" style=display:block>'+res.statusMessage+'</div>');
                    }
                }
            });
        }else{$('err_npwpd').remove();}
    });
}

function respValue(name,data=undefined){
    let val=['','','','','','','','',''];
    if (typeof(data) != "undefined"){
    	val=[data.wp_wr_nama_milik,data.wp_wr_nama,data.wp_wr_almt,data.wp_wr_camat,data.wp_wr_lurah,'','',data.wp_wr_telp,data.wp_wr_status_aktif];
	}
	//console.log(data,val);
	let i=0;
    $('[name="'+name+'['+name+'_pemilik]"]').val(val[i++]);
    $('[name="'+name+'['+name+'_nama]"]').val(val[i++]);
    $('[name="'+name+'['+name+'_alamat]"]').val(val[i++]);
    $('[name="'+name+'['+name+'_kecamatan]"]').val(val[i++]).change();
    $('[name="'+name+'['+name+'_kelurahan]"]').val(val[i++]).change();
    $('[name="'+name+'['+name+'_rt]"]').val(val[i++]);
    $('[name="'+name+'['+name+'_rw]"]').val(val[i++]);
    $('[name="'+name+'['+name+'_telepon]"]').val(val[i++]);
    $('[name="'+name+'[status_aktif_id]"]').val(val[i++].includes('t')?'2':'1').change();
    let th=$('#search_npwpd');
    th.removeAttr('disabled');
    $('.spinner-npwpd').attr('style','display:none');
    th.focus();
    $('.err_npwpd').remove();
}
