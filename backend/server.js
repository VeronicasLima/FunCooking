const pool = require('./db');
const express = require('express');
const cors = require('cors');
require('dotenv').config();
const bcrypt = require('bcrypt');

const app = express();
const PORT = 3000;

app.use(cors());

app.use(express.json());

app.get('/',(req,res) => {
    res.send('Backend FunCooking a funcionar!');
});

app.get('/teste-db',async (req,res) => {
    try {
        const resultado = await pool.query(
            'SELECT NOW() AS data_atual'
        );

        res.json({
            mensagem: 'Ligação ao PostgreSQL realizada com sucesso!',
            data: resultado.rows[0].data_atual
        });

    } catch (erro) {
        console.error('Erro na ligação:',erro);

        res.status(500).json({
            mensagem: 'Erro ao ligar ao PostgreSQL'
        });
    }
});

app.post('/registar',async (req,res) => {
    try {
        const { nome, email, password } = req.body;

        if(
            typeof nome !== 'string' ||
            typeof email !== 'string' ||
            typeof password !== 'string' ||
            !nome.trim() ||
            !email.trim() ||
            !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.trim()) ||
            password.length < 6
        ) {
            return res.status(400).json({
                mensagem: 'Verfica os dados introduzidos.'

        });
        }

        const emailNormalizado = email.trim().toLowerCase();

        const existente = await pool.query(
            'SELECT id_utilizador FROM utilizador WHERE LOWER(email) = $1',
             [emailNormalizado]
        );

        if (existente.rows.length > 0) {
            return res.status(409).json({
                mensagem: 'Este email ja se encontra registado.'
            });
        }

        const passwordHash = await bcrypt.hash(password, 12);

        const resultado = await pool.query(
            'INSERT INTO utilizador (nome, email, password) VALUES ($1, $2, $3) RETURNING id_utilizador, nome, email',
            [nome.trim(),emailNormalizado, passwordHash]
        );

        res.status(201).json({
            mensagem:'Conta registada com sucesso!',
            utilizador: resultado.rows[0]
        });

} catch (erro) {
    console.error('Erro no registo:',erro);

    if (erro.code === '23505') {
        return res.status(409).json({
            mensagem:'Este email já se encontra registado.'
    });
}

res.status(500).json({
    mensagem: 'Erro ao criar conta.'
});
    }
});

app.post('/login', async (req, res) => {
    try {
        const { email, password } = req.body;

        if (
            typeof email !== 'string' ||
            typeof password !== 'string' ||
            !email.trim() ||
            !password
        ) {
            return res.status(400).json({
                mensagem: 'Introduz o email e a palavra-passe.'
            });
        }

        const resultado = await pool.query(
            'SELECT id_utilizador, nome, email, password, tipo_utilizador FROM utilizador WHERE LOWER(email) = $1',
            [email.trim().toLowerCase()]
        );

        if (resultado.rows.length === 0) {
            return res.status(401).json({
                mensagem: 'Email ou palavra-passe inválidos.'
            });
        }

        const utilizador = resultado.rows[0];

        const passwordCorreta = await bcrypt.compare(
            password,
            utilizador.password
        );

        if (!passwordCorreta) {
            return res.status(401).json({
                mensagem: 'Email ou palavra-passe inválidos.'
            });
        }

        res.status(200).json({
            mensagem: 'Início de sessão realizado com sucesso!',
            utilizador: {
                id_utilizador: utilizador.id_utilizador,
                nome: utilizador.nome,
                email: utilizador.email,
                tipo_utilizador: utilizador.tipo_utilizador
            }
        });

    } catch (erro) {
        console.error('Erro no login:', erro);

        res.status(500).json({
            mensagem: 'Erro ao iniciar sessão.'
        });
    }
});

app.post('/receitas',async (req, res) => {

    try {
        const {
            id_utilizador,
            nome,
            numero_pessoas,
            conteudo,
            fotografia
        } = req.body;

        if (
            !Number.isInteger(id_utilizador) ||
            id_utilizador <= 0 ||
            typeof nome !== 'string' ||
            !nome.trim() ||
            !Number.isInteger(numero_pessoas) ||
            numero_pessoas <= 0 ||
            typeof conteudo !== 'string' ||
            !conteudo.trim()
        ) {
            return res.status(400).json ({
                mensagem: 'Prenche todos os campos obrigatorios.'
            });
        }

       
const resultado = await pool.query(
    'INSERT INTO receita (id_utilizador, nome, numero_pessoas, conteudo, fotografia, data_criacao) VALUES ($1, $2, $3, $4, $5, NOW()) RETURNING *',
    [
        id_utilizador,
        nome.trim(),
        numero_pessoas,
        conteudo.trim(),
        fotografia || null
    ]
);


        res.status(201).json({
            mensagem: 'Reeceita guardada com sucesso!',
            receita: resultado.rows[0]
        });
    
    } catch (erro) {
        console.error('Erro ao guardar receita:',erro);

        res.status(500).json({
            mensagem: 'Erro ao guardar receita.'
        });
    }

});

app.listen (PORT, () => {
    console.log('Servidor a funcionar na porta ' + PORT);
});

