import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-gerir-utilizadores',
  templateUrl: './gerir-utilizadores.page.html',
  styleUrls: ['./gerir-utilizadores.page.scss'],
  standalone: false,
})
export class GerirUtilizadoresPage implements OnInit {

  utilizadores: any[] = [];

  constructor() { }

  ngOnInit() {
  }

}
