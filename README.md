# 降低 Gas 費

在真金白銀區塊鏈中 如何降低Gas費 也是很重要的
學習使用 Solidity 中的 Assembly 語法來實作
也順便學習, 練習 單元測試....等..

Solidity Assembly
官網 : https://docs.soliditylang.org/en/v0.4.24/assembly.html

```shell
git clone 
npm install
npx hardhat test
GAS_REPORT=true npx hardhat test
```

註 : Method後面有加Asm的就是有用 Assembly 技術, 會有未使用和使用Assembly來對照
例
|  Contract        ·  Method         ·  Min         ·  Max        ·  Avg        ·  # calls      ·  usd (avg)  │       
···················|·················|··············|·············|·············|···············|··············       
|  CardMiniBitmap  ·  addCards       ·           -  ·          -  ·      50821  ·            1  ·          -  │ --> 未使用 Assembly     
···················|·················|··············|·············|·············|···············|··············       
|  CardMiniBitmap  ·  addCardsAsm    ·           -  ·          -  ·      45534  ·            1  ·          -  │ --> 使用 Assembly



目前 單元測試結果
·------------------------------------|----------------------------|-------------|-----------------------------·       
|        Solc version: 0.8.9         ·  Optimizer enabled: false  ·  Runs: 200  ·  Block limit: 30000000 gas  │       
·····································|····························|·············|······························       
|  Methods                                                                                                    │       
···················|·················|··············|·············|·············|···············|··············       
|  Contract        ·  Method         ·  Min         ·  Max        ·  Avg        ·  # calls      ·  usd (avg)  │       
···················|·················|··············|·············|·············|···············|··············       
|  CardMiniBitmap  ·  addCards       ·           -  ·          -  ·      50821  ·            1  ·          -  │       
···················|·················|··············|·············|·············|···············|··············       
|  CardMiniBitmap  ·  addCardsAsm    ·           -  ·          -  ·      45534  ·            1  ·          -  │       
···················|·················|··············|·············|·············|···············|··············       
|  FomoCard        ·  addCard        ·       27639  ·      44727  ·      39031  ·            3  ·          -  │       
···················|·················|··············|·············|·············|···············|··············       
|  FomoCard        ·  addCardAsm     ·       27448  ·      44536  ·      38840  ·            3  ·          -  │       
···················|·················|··············|·············|·············|···············|··············       
|  FomoCard        ·  removeCard     ·           -  ·          -  ·      27540  ·            1  ·          -  │       
···················|·················|··············|·············|·············|···············|··············       
|  FomoCard        ·  removeCardAsm  ·           -  ·          -  ·      27502  ·            1  ·          -  │       
···················|·················|··············|·············|·············|···············|··············       
|  Deployments                       ·                                          ·  % of limit   ·             │       
·····································|··············|·············|·············|···············|··············       
|  CardMiniBitmap                    ·           -  ·          -  ·    1163458  ·        3.9 %  ·          -  │       
·····································|··············|·············|·············|···············|··············       
|  FomoCard                          ·           -  ·          -  ·    2273760  ·        7.6 %  ·          -  │       
·····································|··············|·············|·············|···············|··············       
|  QuickSort                         ·           -  ·          -  ·     559517  ·        1.9 %  ·          -  │       
·------------------------------------|--------------|-------------|-------------|---------------|-------------·  

