-- phpMyAdmin SQL Dump
-- version 5.2.1deb3
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le : mar. 29 sep. 2026 à 07:30
-- Version du serveur : 10.11.14-MariaDB-0ubuntu0.24.04.1
-- Version de PHP : 8.4.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `Db_Alcool`
--

-- --------------------------------------------------------

--
-- Structure de la table `Drink`
--

CREATE TABLE `Drink` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `session_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `volume_ml` int(11) NOT NULL,
  `degree` int(11) NOT NULL,
  `consumed_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Drink`
--

INSERT INTO `Drink` (`id`, `name`, `session_id`, `user_id`, `volume_ml`, `degree`, `consumed_at`) VALUES
(1, 'Bière blonde', 1, 1, 250, 5, '2026-09-28 20:30:00'),
(2, 'Whisky Coca', 1, 1, 150, 20, '2026-09-28 21:15:00'),
(3, 'Verre de vin rouge', 1, 2, 125, 12, '2026-09-28 20:45:00'),
(4, 'Cocktail Mojito', 1, 2, 200, 10, '2026-09-28 21:30:00');

-- --------------------------------------------------------

--
-- Structure de la table `Session`
--

CREATE TABLE `Session` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `started_at` date NOT NULL,
  `is_active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Session`
--

INSERT INTO `Session` (`id`, `title`, `started_at`, `is_active`) VALUES
(1, 'Soirée Anniversaire', '2026-09-28', 1);

-- --------------------------------------------------------

--
-- Structure de la table `session_user`
--

CREATE TABLE `session_user` (
  `session_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `session_user`
--

INSERT INTO `session_user` (`session_id`, `user_id`) VALUES
(1, 1),
(1, 2);

-- --------------------------------------------------------

--
-- Structure de la table `User`
--

CREATE TABLE `User` (
  `id` int(11) NOT NULL,
  `name` varchar(11) NOT NULL,
  `weight_kg` int(11) NOT NULL,
  `gender` varchar(1) NOT NULL,
  `passworld` varchar(100) NOT NULL,
  `token` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `User`
--

INSERT INTO `User` (`id`, `name`, `weight_kg`, `gender`, `passworld`, `token`) VALUES
(1, 'Thomas', 75, 'H', '1234', '1234'),
(2, 'Sarah', 60, 'F', '1234', '12345');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `Drink`
--
ALTER TABLE `Drink`
  ADD PRIMARY KEY (`id`),
  ADD KEY `session_id` (`session_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Index pour la table `Session`
--
ALTER TABLE `Session`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `session_user`
--
ALTER TABLE `session_user`
  ADD KEY `session_id` (`session_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Index pour la table `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `Drink`
--
ALTER TABLE `Drink`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `Session`
--
ALTER TABLE `Session`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `User`
--
ALTER TABLE `User`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `Drink`
--
ALTER TABLE `Drink`
  ADD CONSTRAINT `Drink_ibfk_1` FOREIGN KEY (`session_id`) REFERENCES `Session` (`id`),
  ADD CONSTRAINT `Drink_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `Drink` (`id`);

--
-- Contraintes pour la table `session_user`
--
ALTER TABLE `session_user`
  ADD CONSTRAINT `session_user_ibfk_1` FOREIGN KEY (`session_id`) REFERENCES `Session` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
