
describe('Tests E2E Performances', () => {
    it('Nouvelle Performance', () => {
        cy.visit('/')

        // cliquer sur la balise a qui a pour href "#collapsePerformances"
        cy.get('a[href="#collapsePerformances"]').click()

        // Cliquer sur la balise <a> redirigeant vers href="/festivals/performances/create"
        cy.get('a[href="/festivals/performances/create"]').click();

        // Attendre que la page de création de performance se charge
        cy.url().should('include', '/festivals/performances/create');

        // Cliquer sur le bouton de création d'artiste
        cy.get('button[class="btn btn-primary flexe"]').contains('Ajouter un nouvel artiste').click();

        // Attendre que la modal apparaisse
        cy.wait(2000);

        // Récupérer le formulaire de création d'artiste
        cy.get('form[id="partnerForm"]').within(() => {

            // Créer le nom de l'artiste
            cy.get('input[id="id_nom"]').type('Test3');

            // Créer la description de l'artiste
            cy.get('textarea[id="id_description"]').type('TestDescription3');

            // Créer le site web de l'artiste
            cy.get('input[id="id_site_web"]').type('https://www.test3.com');

            // Créer le youtube de l'artiste
            cy.get('input[id="id_youtube"]').type('https://www.youtube.com');

            // Créer le instagram de l'artiste
            cy.get('input[id="id_instagram"]').type('https://www.instagram.com');

            // Créer le facebook de l'artiste
            cy.get('input[id="id_facebook"]').type('https://www.facebook.com');

            // Valider le formulaire
            cy.get('input[id="submitBtn"]').click();
        }
        );

        // Récupérer le formulaire de création de performance
        cy.get('form[class="persoForm"]').within(() => {

            // Créer le nom de la performance en prenant bien la première
            cy.get('input[id="id_nom"]').type('PerformanceTest2');

            // Séléctionner la date de début
            cy.get('input[id="id_date"]').type('27/01/2143');

            // Séléctionner l'heure de début
            cy.get('input[id="id_heure_debut"]').type('13:00');

            // Séléctionner l'heure de fin
            cy.get('input[id="id_heure_fin"]').type('20:00');

            // Cocher les artistes participants
            cy.get('input[id="id_artistes_1"]').click();
            cy.get('input[id="id_artistes_2"]').click();
            cy.get('input[id="id_artistes_3"]').click();
            cy.get('input[id="id_artistes_4"]').click();

            // sélectionner la scène
            cy.get('select[id="id_scene"]').select('Mainstage 1');
        });

        //Ajouter le nouvel artiste
        cy.get('input[id="id_artistes_7"]').click();

        // Valider le formulaire
        cy.get('input[value="Enregistrer"]').click();
    }
    );

    it('Mise a jour performance', () => {
        cy.visit('/')

        // cliquer sur la balise a qui a pour href "#collapsePerformances"
        cy.get('a[href="#collapsePerformances"]').click()

        // Cliquer sur la balise <a> redirigeant vers href="/festivals/performances/1"
        cy.get('a[href="/festivals/performances/1"]').click();

        // Attendre que la page des performances se charge
        cy.url().should('include', '/festivals/performances/1');

        // Récupère la performance Test créé précédemment
        cy.get('h3').contains('PerformanceTest').click();

        // Cliquer sur le bouton de modification
        cy.get('a[class="btn btn-warning"]').click();

        // Récupérer le formulaire de création de performance
        cy.get('form[class="persoForm"]').within(() => {

            // Modifier le nom de la performance
            cy.get('input[id="id_nom"]').clear().type('PerformanceTest2');

            // Modifier la date de début
            cy.get('input[id="id_date"]').clear().type('27/01/2003');

            // Modifier l'heure de début
            cy.get('input[id="id_heure_debut"]').clear().type('12:00');

            // Modifier l'heure de fin
            cy.get('input[id="id_heure_fin"]').clear().type('13:00');
            // Modifier la scène
            cy.get('select[id="id_scene"]').select('Mainstage 1');
        }
        );

        // Modifier les artistes participants
        cy.get('input[id="id_artistes_1"]').click();
        cy.get('input[id="id_artistes_2"]').click();
        cy.get('input[id="id_artistes_5"]').click();



        // Valider le formulaire
        cy.get('input[value="Enregistrer"]').click();
    }
    );

    it('Lecture performance', () => {
        cy.visit('/');

        // Cliquer sur la balise a qui a pour href "#collapsePerformances"
        cy.get('a[href="#collapsePerformances"]').click();

        // Cliquer sur la balise <a> redirigeant vers href="/festivals/performances/1"
        cy.get('a[href="/festivals/performances/1"]').click();

        // Attendre que la page des performances se charge
        cy.url().should('include', '/festivals/performances/1');

        // Récupère la performance Test créé précédemment
        cy.contains('h3', 'PerformanceTest2').click();

        // Vérifier que le nom est correct
        cy.get('h2').contains('PerformanceTest2');


        // Vérifier que les informations sont correctes
        cy.get('.table-bordered tbody').within(() => {
            cy.contains('Nom').next('td').should('contain.text', 'PerformanceTest2');
            cy.contains('Date').next('td').should('contain.text', '27 janvier 2143');
            cy.contains('Heure de début - Heure de fin').next('td').should('contain.text', '13:00 - 20:00');
            cy.contains('Scène').next('td').should('contain.text', 'Mainstage 1');

            // Vérifier que le nouvel artiste créé est bien présent
            cy.contains('Artiste(s)').next('td').should('contain.text', 'Test3');
        }
        );

        // Vérifier que la scène est correcte
        cy.get('.table-bordered tbody').within(() => {
            cy.contains('Scène').next('td').should('contain.text', 'Mainstage 1');
        }
        );
    }
    );

    it('Suppression performance', () => {
        cy.visit('/')

        // cliquer sur la balise a qui a pour href "#collapsePerformances"
        cy.get('a[href="#collapsePerformances"]').click()

        // Cliquer sur la balise <a> redirigeant vers href="/festivals/performances/1"
        cy.get('a[href="/festivals/performances/1"]').click();

        // Attendre que la page des performances se charge
        cy.url().should('include', '/festivals/performances/1');

        // Récupère la performance Test créé précédemment
        cy.get('h3').contains('PerformanceTest').click();

        // Cliquer sur le bouton de suppression
        cy.get('a[class="btn btn-danger"]').click();

        // Attendre que la modal apparaisse
        cy.wait(2000);

        // Récupérer le bouton de suppression et cliquer dessus
        cy.get('button[class="btn btn-danger rounded-pill"]').contains('Supprimer PerformanceTest').click();
    }
    );
}
);
export { };