import { Drink } from './drink.js';

// Récupération des éléments du DOM
const form = document.getElementById('alcoolForm');
const poidsInput = document.getElementById('poids');
const genreRadios = document.querySelectorAll('input[name="genre"]');
const volumeInput = document.getElementById('volume');
const degreInput = document.getElementById('degre');
const resultat = document.getElementById('resultat');
const tableBody = document.getElementById('historiqueTableBody');

// Liste des consommations
const consommations = [];

// Sauvegarde dans le localStorage
function sauvegarder() {
    const data = consommations.map(d => ({
        volume: d.volume,
        degre: d.degre,
        heure: d.heurConso
    }));
    localStorage.setItem('conso', JSON.stringify(data));
}

// Chargement depuis le localStorage
function charger() {
    const data = JSON.parse(localStorage.getItem('conso')) || [];
    data.forEach(item => {
        consommations.push(new Drink(item.volume, item.degre, item.heure));
    });
}

function getGenre() {
    return document.querySelector('input[name="genre"]:checked').value;
}

function render() {
    const poids = parseFloat(poidsInput.value);
    const genre = getGenre();

    // Affichage de l'historique
    tableBody.innerHTML = '';
    consommations.forEach((drink, index) => {
        const tr = document.createElement('tr');
        tr.innerHTML = `
            <td>${index + 1}</td>
            <td>${drink.volume} ml</td>
            <td>${drink.degre} %</td>
            <td>${drink.heurConso}</td>
            <td>${drink.getTempsEcoule()}</td>
            <td><button class="btn btn-sm btn-danger" data-id="${drink.id}">Supprimer</button></td>
        `;
        tableBody.appendChild(tr);
    });

    // Calcul du taux total avec élimination globale
    let total = 0;
    if (!isNaN(poids) && poids > 0 && consommations.length > 0) {
        
        // 1. Somme de tous les apports bruts actuels des boissons
        let tauxBrutTotal = 0;
        consommations.forEach(drink => {
            tauxBrutTotal += drink.getTauxMaxBoisson(poids, genre);
        });

        // 2. Temps écoulé depuis la PREMIÈRE consommation pour l'élimination globale
        const premiereDrink = consommations[0];
        const heuresDepuisDebut = premiereDrink.getHeuresEcouleesDecimal();

        // 3. Application de l'élimination globale du foie (0.15 g/L par heure)
        const tauxEliminationGlobal = 0.15;
        total = tauxBrutTotal - (tauxEliminationGlobal * heuresDepuisDebut);
    }

    // Le taux ne peut jamais descendre en dessous de 0
    total = Math.max(0, total);
    resultat.textContent = `Taux d'alcool dans le sang : ${total.toFixed(2)} g/L`;
}

// Ajout d'une consommation
form.addEventListener('submit', (e) => {
    e.preventDefault();
    const volume = parseFloat(volumeInput.value);
    const degre = parseFloat(degreInput.value);

    if (isNaN(volume) || isNaN(degre)) return;

    consommations.push(new Drink(volume, degre));
    sauvegarder();
    render();
});

// Recalcul quand le poids ou le genre change
poidsInput.addEventListener('input', render);
genreRadios.forEach(radio => radio.addEventListener('change', render));

// Suppression d'une consommation
tableBody.addEventListener('click', (e) => {
    const id = parseInt(e.target.dataset.id);
    if (!isNaN(id)) {
        const index = consommations.findIndex(d => d.id === id);
        if (index !== -1) {
            consommations.splice(index, 1);
            sauvegarder();
            render();
        }
    }
});

// Chargement des données sauvegardées puis affichage
charger();
render();

// Mise à jour du temps écoulé et du taux chaque seconde
setInterval(render, 1000);