
$('.deleteCmd').on('click', function () {
	var el = $(this).parent();

	if (confirm('Are you sure to delete?')) {
		$.post('/delete', {
			id: el.data('id')
		}, function () {
			el.fadeOut(800);
		});
	}
});