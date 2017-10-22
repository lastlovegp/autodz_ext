using System;
using System.Collections.Generic;
using System.IO;
using Newtonsoft.Json;

namespace Baidu.Aip.Demo
{
    using Baidu.Aip.Nlp;
    class NlpDemo
    {
        public void Lexer()
        {
            Nlp nlp = new Nlp("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            var result = nlp.Lexer("三大指数齐翻红 低位蓄势蓝筹股可中线持有");
            Console.Write(result);
        }

        public void WordSeg()
        {
            Nlp nlp = new Nlp("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            var result = nlp.WordSeg("今天天气不错");
            Console.Write(result);
        }

        
        public  void WordPos()
        {
            var nlp = new Nlp("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            var result = nlp.WordPos("今天天气不错");
            Console.Write(result);
        }
  
        public  void WordEmbedding()
        {
            var nlp = new Nlp("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            // 词相似度
            var result = nlp.WordEmbeddingSimilarity("北京", "上海");
            Console.Write(result);
            // 词向量
            result = nlp.WordEmbeddingVector("北京");
            Console.Write(result);
        }
        
        public  void Dnnlm()
        {
            var nlp = new Nlp("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            var result = nlp.DNN_LM_Cn("今天天气不错");
            Console.Write(result);
        }
  
        public  void SimNet()
        {
            var nlp = new Nlp("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            var result = nlp.Simnet("你好百度", "你好世界");
            Console.Write(result);
        }

        public  void CommentTag()
        {
            var nlp = new Nlp("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            var result = nlp.CommentTag("个人觉得这车不错，外观漂亮年轻，动力和操控性都不错", 10);
            Console.Write(result);
        }

        public  void SentimentClassify()
        {
            var nlp = new Nlp("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            var result = nlp.SentimentClassify("个人觉得这车不错，外观漂亮年轻，动力和操控性都不错");
            Console.Write(result);
        }

        public  void DepParser()
        {
            var nlp = new Nlp("VWXpqPVIH1NbGkp7pojoRUXG", "Cmjkfx7Lxs2RdAc72TOtY2MFwIta8w5p ");
            var options = new Dictionary<string, object>()
            {
                {"mode", 1}
            };
            var result = nlp.DepParser("今天天气不错", options);
            Console.Write(result);
        }

    }
}