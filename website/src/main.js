import './style.css'

// Mobile menu toggle
document.querySelectorAll('[data-collapse-toggle]').forEach(button => {
    const targetId = button.getAttribute('data-collapse-toggle');
    const target = document.getElementById(targetId);

    button.addEventListener('click', () => {
        if (target) {
            target.classList.toggle('hidden');
        }
    });

    // Collapse mobile menu when a nav link is clicked
    if (target) {
        target.querySelectorAll('a').forEach(link => {
            link.addEventListener('click', () => {
                target.classList.add('hidden');
            });
        });
    }
});
