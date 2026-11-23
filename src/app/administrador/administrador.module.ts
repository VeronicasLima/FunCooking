import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

import { IonicModule } from '@ionic/angular/lazy';

import { AdministradorPageRoutingModule } from './administrador-routing.module';

import { AdministradorPage } from './administrador.page';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    AdministradorPageRoutingModule
  ],
  declarations: [AdministradorPage]
})
export class AdministradorPageModule {}
