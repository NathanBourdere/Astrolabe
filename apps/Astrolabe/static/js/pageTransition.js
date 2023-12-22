
// Add a click event listener to your navigation links
document.querySelectorAll('.nav-link').forEach(link => {
    link.addEventListener('click', function (event) {
        event.preventDefault();

        // Get the target page URL
        const targetUrl = this.getAttribute('href');

        // Apply the zoom-out effect to the current page
        document.body.classList.add('zoom-out');

        // After a short delay, navigate to the target page
        setTimeout(() => {
            window.location.href = targetUrl;
        }, 300); // Adjust the delay based on your transition time
    });
});

document.addEventListener('DOMContentLoaded', function () {
    // Apply the zoom-in effect to the new page
    document.body.classList.add('zoom-in');
});

