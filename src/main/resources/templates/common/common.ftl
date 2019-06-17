<script id="createTime" type="text/html">
    {{#
    if(d.createTime){
    var date = new Date();
    date.setTime(d.createTime);
    return date.Format("yyyy-MM-dd hh:mm:ss");
    }
    }}
</script>
<script id="updateTime" type="text/html">
    {{#
    if(d.updateTime){
    var date = new Date();
    date.setTime(d.updateTime);
    return date.Format("yyyy-MM-dd hh:mm:ss");
    }
    }}
</script>