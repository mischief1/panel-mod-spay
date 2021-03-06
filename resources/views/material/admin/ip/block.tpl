

{include file='admin/main.tpl'}







	<main class="content">
		<div class="content-header ui-content-header">
			<div class="container">
				<h1 class="content-heading">节点被封IP</h1>
			</div>
		</div>
		<div class="container">
			<div class="col-lg-12 col-sm-12">
				<section class="content-inner margin-top-no">
					
					<div class="card">
						<div class="card-main">
							<div class="card-inner">
								<p>这里是最近的节点上捕捉到的进行非法行为的IP。</p>
							</div>
						</div>
					</div>
					
					<div class="card">
						<div class="card-main">
							<div class="card-inner">
								<div class="form-group form-group-label">
									<label class="floating-label" for="ip">要解封的IP</label>
									<input class="form-control" id="ip" type="text">
								</div>
								
								
							</div>
							
							<div class="card-action">
								<div class="card-action-btn pull-left">
									<a class="btn btn-flat waves-attach" id="unblock" ><span class="icon">check</span>&nbsp;解封</a>
								</div>
							</div>
						</div>
					</div>
					
					<div class="table-responsive">
						{$logs->render()}
						
						<table class="table">
							<tr>
								<th>ID</th>
								<th>节点ID</th>
								<th>节点名称</th>
								<th>IP</th>
								<th>归属地</th>
								<th>时间</th>
							</tr>
							{foreach $logs as $log}
								<tr>
									<td>#{$log->id}</td>
									<td>{$log->node()->id}</td>
									<td>{$log->node()->name}</td>
									<td>{$log->ip}</td>
									<td>{$loc[$log->ip]}</td>
									<td>{$log->time()}</td>
								</tr>
							{/foreach}
						</table>
                        {$logs->render()}
					</div>
					
					{include file='dialog.tpl'}

							
			</div>
			
			
			
		</div>
	</main>












{include file='admin/footer.tpl'}


<script>
    $("#unblock").click(function () {
            $.ajax({
                type: "POST",
                url: "/admin/unblock",
                dataType: "json",
                data: {
                    ip: $("#ip").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#result").modal();
                        $("#msg").html(data.msg);
                        window.setTimeout("location.href=window.location.href", {$config['jump_delay']});
                    }
					else
					{
						$("#result").modal();
                        $("#msg").html(data.msg);
					}
                    // window.location.reload();
                },
                error: function (jqXHR) {
                    alert("发生错误：" + jqXHR.status);
                }
            })
        })
</script>