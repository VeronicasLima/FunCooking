import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-criar-receita',
  templateUrl: './criar-receita.page.html',
  styleUrls: ['./criar-receita.page.scss'],
  standalone: false
})

export class CriarReceitaPage implements OnInit {

  nome: string = '';
  numeroPessoas: number | null = null;
  preparacao: string = '';
  fotografia: string | null = null;
  isLoading: boolean = false;

  ingredientes = [
    {
      nome: '',
      quantidade: null as number | null,
      unidade: ''
    }
  ];

  constructor(
    private http: HttpClient,
    private router: Router
  ) {}

  ngOnInit() {}

  adicionarIngrediente() {
    this.ingredientes.push({
      nome: '',
      quantidade: null,
      unidade: ''
    });
  }

  removerIngrediente(index: number) {
    if (this.ingredientes.length > 1) {
      this.ingredientes.splice(index, 1);
    }
  }

  selecionarFotografia(event: Event) {

    const input = event.target as HTMLInputElement;
    const ficheiro = input.files?.[0];

    if (ficheiro) {

      if (!ficheiro.type.startsWith('image/')) {
        alert('Seleciona uma imagem válida.');
        return;
      }

      const reader = new FileReader();

      reader.onload = () => {
        this.fotografia = reader.result as string;
      };

      reader.onerror = () => {
        alert('Não foi possível abrir a fotografia.');
      };

      reader.readAsDataURL(ficheiro);
    }
  }

  guardarReceita() {

    console.table(this.ingredientes);

    if (this.isLoading) {
      return;
    }

    if (
      !this.nome.trim() ||
      !this.numeroPessoas ||
      !Number.isInteger(this.numeroPessoas) ||
      this.numeroPessoas <= 0 ||
      !this.preparacao.trim()
    ) {
      alert('Preenche todos os campos obrigatórios.');
      return;
    }

    const ingredientesInvalidos = this.ingredientes.some (
       ingrediente =>
        !ingrediente.nome.trim() ||
        ingrediente.quantidade === null ||
        !Number.isFinite(Number(ingrediente.quantidade)) ||
          Number(ingrediente.quantidade) <= 0 ||
        !ingrediente.unidade
    );
     
    if (ingredientesInvalidos) {
      alert('Preenche corretamente todos os ingredientes.');
      return;
    }

    const dadosUtilizador = localStorage.getItem('utilizador');

    if (!dadosUtilizador) {
      alert('Inicia sessão novamente.');
      this.router.navigate(['/login']);
      return;
    }

    let idUtilizador: number;

    try {

      idUtilizador = Number(
        JSON.parse(dadosUtilizador).id_utilizador
      );

    } catch {

      alert('Sessão inválida.');
      this.router.navigate(['/login']);
      return;

    }

    if (!Number.isInteger(idUtilizador) || idUtilizador <= 0) {
      alert('Sessão inválida.');
      this.router.navigate(['/login']);
      return;
    }

    const receita = {
      id_utilizador: idUtilizador,
      nome: this.nome.trim(),
      numero_pessoas: this.numeroPessoas,
      conteudo: this.preparacao.trim(),
      ingredientes: this.ingredientes,
      fotografia: null
    };

    this.isLoading = true;

    this.http.post(
      'http://localhost:3000/receitas',
      receita
    ).subscribe({

      next: () => {

        this.isLoading = false;

        alert('Receita guardada com sucesso!');

        this.router.navigate(['/receitas']);

      },

      error: (erro: HttpErrorResponse) => {

        this.isLoading = false;

        console.error(erro);

        alert(
          erro.error?.mensagem ||
          'Não foi possível guardar a receita.'
        );

      }

    });
  }
}


