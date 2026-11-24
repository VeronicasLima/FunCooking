import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

import { IonicModule } from '@ionic/angular/lazy';

import { GerirUtilizadoresPageRoutingModule } from './gerir-utilizadores-routing.module';

import { GerirUtilizadoresPage } from './gerir-utilizadores.page';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    GerirUtilizadoresPageRoutingModule
  ],
  declarations: [GerirUtilizadoresPage]
})
export class GerirUtilizadoresPageModule {}
