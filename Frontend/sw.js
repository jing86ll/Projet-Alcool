const CACHE_NAME = 'alcool-v1';

const ASSETS = [
    './',
    './index.html',
    './manifest.webmanifest',
    './js/main.js',
    './js/drink.js',
    './icons/icon-192.png',
    './icons/icon-512.png',
    './icons/icon-512-maskable.png',
    'https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css'
];

self.addEventListener('install', (event) => {
    event.waitUntil(
        caches.open(CACHE_NAME).then((cache) => cache.addAll(ASSETS))
    );
    self.skipWaiting();
});

self.addEventListener('activate', (event) => {
    event.waitUntil(
        caches.keys().then((keys) =>
            Promise.all(keys.filter((k) => k !== CACHE_NAME).map((k) => caches.delete(k)))
        )
    );
    self.clients.claim();
});

self.addEventListener('fetch', (event) => {
    event.respondWith(
        caches.match(event.request).then((cached) => cached || fetch(event.request))
    );
});
