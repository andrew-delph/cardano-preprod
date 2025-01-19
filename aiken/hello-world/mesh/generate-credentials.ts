
import fs from 'node:fs';
import { Lucid } from "https://deno.land/x/lucid@0.8.3/mod.ts";

import { MeshWallet } from '@meshsdk/core';
function greet(name: string): string {
    return `Hello, ${name}!`;
}

console.log(greet("world"));
console.log(Lucid)


console.log(MeshWallet)


// const secret_key = MeshWallet.brew(true) as string;

// fs.writeFileSync('me.sk', secret_key);

// const wallet = new MeshWallet({
//     networkId: 0,
//     key: {
//         type: 'root',
//         bech32: secret_key,
//     },
// });

// fs.writeFileSync('me.addr', wallet.getUnusedAddresses()[0]);