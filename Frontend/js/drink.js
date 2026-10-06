export class Drink {
    static compteurId = 1;

    #id = 0;
    #volume = 0;
    #degre = 0;
    #heurConso = "";

    constructor(volume, degre) {
        this.#id = Drink.compteurId++;
        this.#volume = volume;
        this.#degre = degre;
        this.#heurConso = this.#getCurrentTime();
    }

    get id() { return this.#id; }
    get volume() { return this.#volume; }
    get degre() { return this.#degre; }
    get heurConso() { return this.#heurConso; }

    calculerTaux(poids, genre) {
        const facteur = genre === 'homme' ? 0.7 : 0.6;
        return (this.#volume * (this.#degre / 100) * 0.8) / (poids * facteur);
    }

    getTempsEcoule() {
        const now = new Date();
        const [hours, minutes, seconds = 0] = this.#heurConso.split(':').map(Number);
        const target = new Date(now);
        target.setHours(hours, minutes, seconds, 0);

        const diffMs = Math.abs(target - now);
        const totalSeconds = Math.floor(diffMs / 1000);
        
        const h = String(Math.floor(totalSeconds / 3600)).padStart(2, '0');
        const m = String(Math.floor((totalSeconds % 3600) / 60)).padStart(2, '0');
        const s = String(totalSeconds % 60).padStart(2, '0');

        return `${h}:${m}:${s}`;
    }

    #getCurrentTime() {
        const now = new Date();
        return now.toLocaleTimeString('fr-FR', { hour: '2-digit', minute: '2-digit', second: '2-digit' });
    }
}