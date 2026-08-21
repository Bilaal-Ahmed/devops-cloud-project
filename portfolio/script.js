const menu = document.querySelector('.menu');
const links = document.querySelector('.nav-links');

menu.addEventListener('click', () => links.classList.toggle('open'));

document.querySelectorAll('.nav-links a').forEach(a => {
  a.addEventListener('click', () => links.classList.remove('open'));
});

const observer = new IntersectionObserver(entries => {
  entries.forEach(e => {
    if (e.isIntersecting) e.target.classList.add('show');
  });
}, { threshold: 0.12 });

document.querySelectorAll('.reveal').forEach(el => observer.observe(el));

const topBtn = document.getElementById('top');
window.addEventListener('scroll', () => {
  topBtn.style.display = window.scrollY > 500 ? 'block' : 'none';
});

topBtn.onclick = () => window.scrollTo({ top: 0, behavior: 'smooth' });

document.getElementById('year').textContent = new Date().getFullYear();
