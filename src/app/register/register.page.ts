import { Component, OnInit } from '@angular/core';
import { FormBuilder,FormGroup,Validators } from '@angular/forms';
import { HttpClient,HttpErrorResponse} from '@angular/common/http';
import { Router } from '@angular/router';

@Component({
  selector: 'app-register',
  templateUrl: './register.page.html',
  styleUrls: ['./register.page.scss'],
  standalone: false,
})
export class RegisterPage implements OnInit {

    registerForm!:FormGroup;
    registerError:string ='';

  constructor(
    private formBuilder: FormBuilder,
    private http: HttpClient,
    private router:Router
  ) { }

  ngOnInit() {
    this.registerForm = this.formBuilder.group({
      nome: ['',Validators.required],

      email: ['',[
        Validators.required,
        Validators.email
      ]],

      password:['',[
        Validators.required,
        Validators.minLength(6)
      ]],
    });

    this.registerForm.valueChanges.subscribe(() => {
      this.registerError='';
    });
  }

  register() {

    if (this.registerForm.invalid) {
      this.registerForm.markAllAsTouched();
      return;
    }

      this.registerError = '';
        
   const dados = this.registerForm.value;

   this.http.post<any>(
      'http://localhost:3000/registar',
      dados
).subscribe({
  next: (resposta) => {
    console.log('Registo realizado: ',resposta);

    alert('Conta criada com sucesso!');

    this.router.navigate(['/login']);
  },

  error: (erro:HttpErrorResponse) => {
    console.error('Erro no registo:',erro);

    this.registerError=
    erro.error?.mnesagem ||
      'Não foi possível criar a conta.Tenta novamente.';
  }
});
  }
}
