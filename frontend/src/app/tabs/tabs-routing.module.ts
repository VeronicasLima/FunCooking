
import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { TabsPage } from './tabs.page';

const routes: Routes = [
  {
    path: '',
    component: TabsPage,
    children: [
      {
        path: 'inicio',
        loadChildren: () =>
          import('./tabs2/inicio/inicio.module')
            .then(m => m.InicioPageModule)
      },
      {
        path: 'pesquisar',
        loadChildren: () =>
          import('./tabs2/pesquisar/pesquisar.module')
            .then(m => m.PesquisarPageModule)
      },
      {
        path: 'favoritos',
        loadChildren: () =>
          import('./tabs2/favoritos/favoritos.module')
            .then(m => m.FavoritosPageModule)
      },
      {
        path: 'perfil',
        loadChildren: () =>
          import('./tabs2/perfil/perfil.module')
            .then(m => m.PerfilPageModule)
      },
      {
        path: '',
        redirectTo: 'inicio',
        pathMatch: 'full'
      }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class TabsPageRoutingModule {}

