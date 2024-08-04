<?php
    function generateDate($date, $date_format)
    {
        if(@$date){
            return \Carbon\Carbon::createFromFormat('Y-m-d', $date)->format($date_format);
        }else{
            return '-';
        }
    }

    function generateRupiah($string, $withRp = true)
    {
        if(@$string){
            return $withRp ? 'Rp. '.number_format($string,2,',','.') : number_format($string,2,',','.');
        }else{
            return $withRp ? 'Rp. 0' : '0';
        }
    }

    function generateNumber($string)
    {
        if(@$string){
            return number_format($string,0,',','.');
        }else{
            return '0';
        }
    }

    function toUpper($string)
    {
        return @$string ? strtoupper($string) : null;
    }
